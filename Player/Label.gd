extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.rect_position.y -= 2
	self.percent_visible -= delta
	
	if percent_visible < 0.1:
		self.queue_free()
