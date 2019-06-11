extends Sprite



var on : bool = false
var _toggle_timer: float = 1.0

export var DRAIN_TIMER: float 
var _drain_timer: float = self.DRAIN_TIMER

var energy = 51
func _ready():
	pass 
	
func _process(delta):
	toggle(delta)
	drainBattery(delta)
	$Light2D.enabled = self.on
	self.rotation_degrees = self.get_parent().position.angle_to_point(get_global_mouse_position()) * 180/PI - 180

func addEnergy(amount:int):
	self.energy += amount 
	if self.energy > 100:
		self.energy = 100

func subEnergy(amount:int):
	self.energy -= amount
	if self.energy < 0:
		self.energy = 0
		
func getEnergy():
	return self.energy
export var coins = 0

func toggle(delta):
	if self._toggle_timer != 1.0:
		_toggle_timer -= delta
		if self._toggle_timer < 0:
			_toggle_timer = 1.0
	if Input.is_mouse_button_pressed(BUTTON_LEFT) && self._toggle_timer == 1.0 && self.energy != 0:
		self.on = !self.on
		self._toggle_timer -= 0.01
		
		if self.on:
			self.subEnergy(1)
	elif self.energy == 0:
		self.on = false

func drainBattery(delta):
	if self.on:
		self._drain_timer -= delta
	if self._drain_timer <= 0:
		subEnergy(1)
		self._drain_timer = self.DRAIN_TIMER
		
func is_on():
	return self.on

func _on_Area2D_area_entered(area):
	if area.has_method("in_flashlight_start"):
		area.in_flashlight_start()


func _on_Area2D_area_exited(area):
	if area.has_method("in_flashlight_end"):
		area.in_flashlight_end()
