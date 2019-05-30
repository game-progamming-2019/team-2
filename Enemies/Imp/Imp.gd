extends KinematicBody2D

var direction:Vector2 = Vector2()
var velocity:Vector2 = Vector2()
export var SPEED: int
export var GRAVITY: int
var _apply_gravity: bool = true
var _player_position:Vector2

var _state: String = ""
var _previous_state: String = ""
var _stand_up_time = 0
var _facing: String
	
func check_if_gravity_should_be_applied():
	#List of Conditions
	if is_on_floor():
		_apply_gravity = false
	else:
		_apply_gravity = true
	
func setVelocity(delta):
	decideAction(delta)
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

func decideAction(delta):
	self.direction = Vector2(0,0)
	var player = _player_position.x
	
	if self._stand_up_time > 0:
		self._stand_up_time -= delta
	if _stand_up_time <= 0:
		if player < self.position.x:
			self._facing = "Left"
			self._state = "Walking"
			self.direction = Vector2(-1,0)
		elif player > self.position.x:
			self._facing = "Right"
			self._state = "Walking"
			self.direction = Vector2(1,0)
		if abs(abs(player) - abs(self.position.x)) > 400:
			self._state = "Sleeping"
			self.direction = Vector2(0,0)
		animate()
		self._previous_state = _state 
	
func animate():
	if _previous_state == "Sleeping" && _state == "Walking":
		if self._facing == "Left":
			$Sprite/AnimationPlayer.play("Wake_Up_Left")
		else:
			$Sprite/AnimationPlayer.play("Wake_Up_Right")
		self._stand_up_time = 1
	elif self._state == "Walking":
		if self._facing == "Left":
			$Sprite/AnimationPlayer.play("Left")
		else:
			$Sprite/AnimationPlayer.play("Right")
	elif _state == "Searching":
		if self._facing == "Left":
			$Sprite/AnimationPlayer.play("Lookout_Left")
		else:
			$Sprite/AnimationPlayer.play("Lookout_Right")
	elif (_state == "Sleeping" && _previous_state == "Walking") || (_state == "Sleeping" && _previous_state == ""):
		if self._facing == "Left":
			$Sprite/AnimationPlayer.play("Fall_Asleep_Left")
		else:
			$Sprite/AnimationPlayer.play("Fall_Asleep_Right")
	else:
		pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	setVelocity(delta)
	var snap = Vector2.UP * 32
	move_and_slide_with_snap(self.velocity, snap, Vector2.UP)

func _on_Spieler_Player_position(position):
	self._player_position = position
