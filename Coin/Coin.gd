extends Area2D

export var collision_name = "Player"

signal collision

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#$Sprite/AnimationPlayer.play("Drehen")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Area2D_body_entered(body):
	
	if body.name == collision_name:
		emit_signal("collision")
		queue_free()
	
	
