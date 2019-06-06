extends Camera2D

export var speed: int

func _ready():
	pass # Replace with function body.

func _process(delta):
	self.position.x = self.position.x + delta * speed
