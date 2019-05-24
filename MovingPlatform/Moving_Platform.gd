extends KinematicBody2D

# Declare member variables here. Examples:
export var DIRECTION: Vector2
export var DISTANCE: float
export var SPEED: float
var _starting_position: Vector2
var _traveled_distance: float

func _ready():
	self._starting_position = self.position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	_traveled_distance = (self._starting_position - self.position).length()
	if self._traveled_distance < self.DISTANCE:
		self.position += self.DIRECTION * self.SPEED * delta
	else:
		print(_traveled_distance)
		_starting_position = self.position
		self.DIRECTION = -self.DIRECTION
