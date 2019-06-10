extends Enemy

export var speed = 100
export var distance = 100

var old_distance
var old_position
var stop_position
var direction = Vector2(1,0)
var tween
var stuned = false
var was_stuned = false 


func on_flashlight_start():
	stuned = true
	tween.stop_all()
	direction = Vector2(0,1)
	_start_tween()
	
	


func on_flashlight_end():
	
	stuned = false 
	was_stuned = true 
	
	direction = old_position - stop_position
	distance =  sqrt(pow(old_position.x - stop_position.x,2) + pow(old_position.y - stop_position.y,2))
	direction = direction.normalized()
		
	_start_tween()
	
	


func _start_tween():
	
	var duration = 0
	if speed != 0:
		 duration = distance / speed
		
	tween.interpolate_property(self,"position", self.position, self.position + direction * self.distance, duration, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT) 
	tween.start()
	



func _on_Tween_tween_completed(object, key):
	
	if was_stuned:
		distance = old_distance
		direction = Vector2(1,0)
		was_stuned = false 
	else:
		direction *= -1
	_start_tween()
	


func _on_Enemy_body_shape_entered(body_id, body, body_shape, area_shape):
	
	if body.name != "Player":
		old_distance = distance
		stop_position = position 
		tween.stop_all()
	

func _ready():
	old_position = position
	tween = Tween.new()
	tween.connect("tween_completed",self,"_on_Tween_tween_completed")
	add_child(tween)
	_start_tween()

