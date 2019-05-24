extends Label

func init(text):
	self.text = text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.rect_position.y -= 2
	self.percent_visible -= delta
	
	if percent_visible < 0.1:
		self.queue_free()
