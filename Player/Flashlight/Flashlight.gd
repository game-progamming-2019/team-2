extends Sprite

signal bodies_in_cone

var on : bool = false
var _toggle_timer: float = 1.0

func toggle(delta):
	if self._toggle_timer != 1.0:
		_toggle_timer -= delta
		if self._toggle_timer < 0:
			_toggle_timer = 1.0
	if Input.is_mouse_button_pressed(BUTTON_LEFT) && self._toggle_timer == 1.0:
		self.on = !self.on
		self._toggle_timer -= 0.01

func is_on():
	return self.on

func _ready():
	pass 
	
func _process(delta):
	toggle(delta)
	$Light2D.enabled = self.on
	self.rotation_degrees = self.get_parent().position.angle_to_point(get_global_mouse_position()) * 180/PI - 180
	$Area2D/CollisionPolygon2D.disabled = !on

func _on_Area2D_area_entered(area):
	print ("entered")
	if area.has_method("on_flashlight_start") and on :
		print ("method")
		area.on_flashlight_start()


func _on_Area2D_area_exited(area):
	if area.has_method("on_flashlight_end"):
		area.on_flashlight_end()
