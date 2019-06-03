extends KinematicBody2D

signal Player_position
## Scenes which can be instantiated
var Notification = load("res://Player/Notifications/Notification.tscn")

var direction:Vector2 = Vector2()
var velocity:Vector2 = Vector2()

export var SPEED: int
# milliseconds needed to reach maximum speed
export var ACCELERATION: float = 0.09
export var RUNSPEED_MULTIPLIER: float
export var GRAVITY: int

export var HEAL_MULTIPLIER: float = 0.5
export var DAMAGE_MULTIPLIER: float = 0.5
var _hp: float = 3
var _max_hp: float = 3

#Movement
var _jump_value: float = 1
var _state: String
var _lock = true
var _in_air: bool
var _apply_gravity: bool = true
var _is_running: bool
var _jumping: bool = false
	
	
func _ready():
	pass

func reset():
	self.velocity = Vector2.ZERO
	self.direction = Vector2.ZERO
	
func get_hp():
	return self._hp

# Returns false if the damage was lethal
# Otherwise the function returns true
func take_damge(amount:int):
	self._hp -= amount * DAMAGE_MULTIPLIER
	if self._hp <= 0:
		return false
	else:
		return true

func heal(amount: int):
	self._hp += amount * HEAL_MULTIPLIER
	if self._hp > self._max_hp:
		self._hp = self._max_hp
	
#Signal handler
func _on_Coin_collected():
	var notification = Notification.instance()
	self.add_child(notification)
	notification.init("Coin Collected")
	
func check_if_gravity_should_be_applied():
	#List of Conditions
	if is_on_floor():
		_apply_gravity = false
	else:
		_apply_gravity = true
		
func applyGravity():
	check_if_gravity_should_be_applied()
	if self.direction.y != 0:
		return
	else:
		if _apply_gravity:
			self.velocity.y = self.GRAVITY
		else:
			self.velocity.y = 0

func getInput():
	direction = Vector2(0,0)
	if Input.is_key_pressed(KEY_D):
		self._state = "Moving"
		direction.x = 1
		#$"Spieler - Sprite"/AnimationPlayer.play("Right")
	elif Input.is_key_pressed(KEY_A):
		self._state = "Moving"
		direction.x = -1
		#$"Spieler - Sprite"/AnimationPlayer.play("Left")
	else:
		self._state = "Standing"
		direction.x = 0
		#$"Spieler - Sprite"/AnimationPlayer.stop()
	if Input.is_key_pressed(KEY_SHIFT):
		self._is_running = true
	else:
		self._is_running = false
		
func jump(delta):
	if self.is_on_floor() && Input.is_key_pressed(KEY_SPACE):
		self._jumping = true
	if self._jumping == true:
		# Mathematical function, which is ran from 1 to -1
		self.direction.y = -pow(self._jump_value, 1)
		self._jump_value -= delta 
		if self.is_on_floor() && _jump_value < 0.8:
			self._jumping = false
			self._jump_value = 1
			self._lock = true
		if self.is_on_ceiling() && self._lock:
			self._lock = false
			self._jump_value =  -self._jump_value

func setVelocity():
	if self._state == "Standing" && !self._in_air:
		self.velocity = Vector2.ZERO
	if self._is_running:
		self.velocity.x += (self.direction.x * ( self.SPEED * self.ACCELERATION )) * self.RUNSPEED_MULTIPLIER
	else:
		self.velocity.x += self.direction.x * ( self.SPEED * self.ACCELERATION )
	self.velocity.y = self.direction.y * self.SPEED
	if abs(self.velocity.x) > self.SPEED && !self._is_running && self._state == "Moving":
		self.velocity.x = self.direction.x * self.SPEED
	elif (abs(self.velocity.x) > self.SPEED * self.RUNSPEED_MULTIPLIER) && self._is_running:
		self.velocity.x = self.direction.x * self.SPEED * self.RUNSPEED_MULTIPLIER
	elif self._state == "Standing" && self._in_air && (abs(self.velocity.x) > self.SPEED) && !self._is_running:
		if self.velocity.x <= 0:
			self.velocity.x = -self.SPEED
		else:
			self.velocity.x = self.SPEED

func applyMovement(delta:float):
	getInput()
	jump(delta)
	setVelocity()
	applyGravity()
	
	#print(self.velocity.x)
	
	#var snap = Vector2.UP * 32 if !_jumping else Vector2.ZERO
	#move_and_slide_with_snap(self.velocity, snap, Vector2.UP)
	
	move_and_slide(self.velocity, Vector2.UP)
	emit_signal("Player_position", self.position)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self._in_air = !self.is_on_floor()
	applyMovement(delta)
	