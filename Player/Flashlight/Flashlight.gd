extends Sprite

var _on : bool = false
var _toggle_timer: float = 1.0

func toggle(delta):
	if self._toggle_timer != 1.0:
		_toggle_timer -= delta
		if self._toggle_timer < 0:
			_toggle_timer = 1.0
	if Input.is_mouse_button_pressed(BUTTON_LEFT) && self._toggle_timer == 1.0:
		self._on = !self._on
		self._toggle_timer -= 0.01


func _ready():
	pass 
	
func _process(delta):
	toggle(delta)

	$Light2D.enabled = self._on
	self.rotation_degrees = self.get_parent().position.angle_to_point(get_global_mouse_position()) * 180/PI - 180
