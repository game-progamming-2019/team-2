extends Enemy

export var speed = 100
export var distance = 100
export var stuntime = 5

var start_position = Vector2(0,0)
var direction = Vector2(1,0)

var old_distance 
var old_direction
var fall_distance

var tween
var stuned = false
var walking = true 
var falling = false
var restart_walking = false 



func on_flashlight_start():
	
	if walking:
		old_direction = direction
		direction = Vector2(0,1)
		walking = false
		falling = true
		_start_tween()
		

func on_flashlight_end():
	
	if stuned:
		yield(get_tree().create_timer(stuntime), "timeout")
		direction = Vector2(0,-1)
		_start_tween()
		print("Tween restarted")
	
	
func _start_tween():
	
	var duration = 0
	if speed != 0:
		 duration = distance / speed
	tween.interpolate_property(self,"position", self.position, self.position + direction * self.distance, duration, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT) 
	tween.start()
	



func _on_Tween_tween_completed(object, key):
	
	if walking:
		direction *= -1 
		_start_tween()
		
	elif stuned:
		
		direction = old_direction
		print("Old_Distance"+String(old_distance))
		
		if direction.x < 0:
			print(old_distance," ", position.x ," ", start_position.x)
			print("Kleiner 0")
			distance = _get_Betrag(position.x - start_position.x)
			
		else:
			print("Größer 0")
			distance = old_distance - _get_Betrag(position.x - start_position.x)
			
		print("New_Distance"+String(distance))
		stuned = false 
		restart_walking = true
		_start_tween()
		
	elif restart_walking:
		print("Restart walking")
		
		direction *= -1 
		distance = old_distance
		print(distance)
		restart_walking = false
		walking = true
		_start_tween()


func _on_Enemy_body_shape_entered(body_id, body, body_shape, area_shape):
	
	if body.name != "Player" and falling:
		stuned = true 
		#fall_distance = distance
		distance = position.y - start_position.y
		tween.stop_all()
	
	if body.name == "Player":
		body.get_parent().death()
	
	
func _get_Betrag(var x :float):
	
	if x > 0:
		return x
	else:
		x *= -1
		return x


func _ready():
	old_distance = distance
	start_position = position
	tween = Tween.new()
	tween.connect("tween_completed",self,"_on_Tween_tween_completed")
	add_child(tween)
	_start_tween()

