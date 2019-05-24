extends KinematicBody2D

signal Player_position
## Scenes which can be instantiated
var Notification = load("res://Player/Notifications/Notification.tscn")
# friction
var direction:Vector2 = Vector2()
var velocity:Vector2 = Vector2()
export var SPEED: int
export var GRAVITY: int
var _apply_gravity: bool = true
var _jump_value: float = 1
var _jumping: bool = false
	
func check_if_gravity_should_be_applied():
	#List of Conditions
	if is_on_floor():
		_apply_gravity = false
	else:
		_apply_gravity = true
	
func setVelocity(delta):
	getInput()
	jump(delta)
	#Reset Velocity Vector
	self.velocity = Vector2.ZERO
	self.velocity.x = self.direction.x * self.SPEED
	applyGravity()
	
func applyGravity():
	
	check_if_gravity_should_be_applied()
		
	if self.direction.y != 0:
		self.velocity.y = self.direction.y * self.SPEED
	else:
		if _apply_gravity:
			self.velocity.y = self.GRAVITY
		else:
			self.velocity.y = 0

func getInput():
	direction = Vector2(0,0)
	if Input.is_key_pressed(KEY_RIGHT):
		direction.x = 1
		$"Spieler - Sprite"/AnimationPlayer.play("Right")
	elif Input.is_key_pressed(KEY_LEFT):
		direction.x = -1
		$"Spieler - Sprite"/AnimationPlayer.play("Left")
	else:
		direction.x = 0
		$"Spieler - Sprite"/AnimationPlayer.stop()
		
func jump(delta):
	if self.is_on_floor() && Input.is_key_pressed(KEY_UP):
		self._jumping = true
	if self._jumping == true:
		# Mathematical function, which is ran from 1 to -1
		self.direction.y = -pow(self._jump_value, 1)
		self._jump_value -= delta 
		if self.is_on_floor() && _jump_value < 0.8:
			self._jumping = false
			self._jump_value = 1
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	setVelocity(delta)
	var snap = Vector2.UP * 32 if !_jumping else Vector2.ZERO
	move_and_slide_with_snap(self.velocity, snap, Vector2.UP)
	emit_signal("Player_position", self.position)
	
#Signal handler
func _on_Coin_collected():
	var notification = Notification.instance()
	self.add_child(notification)
	notification.init("Coin Collected")