extends Enemy

export var speed = 100
export var distance = 100
var direction = Vector2(1,0)
var tween

var enemy: Enemy

func _init(e:Enemy):
	enemy = e
	
func on_flashlight_start():
	
	direction= Vector2(0,1)
	
	print("on_flashlight_start() has not been overwritten")


func on_flashlight_end():
	direction = Vector2(1,0)
	

func _ready():
	
	tween = Tween.new()
	tween.connect("tween_completed",self,"_on_Tween_tween_completed")
	add_child(tween)
	_start_tween()
	pass # Replace with function body.

func _start_tween():
	var duration = distance / speed
	tween.interpolate_property(self,"position", self.position, self.position + direction * self.distance, duration, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT) 
	tween.start()

func _on_Tween_tween_completed(object, key):
	direction *= -1
	_start_tween()
	

