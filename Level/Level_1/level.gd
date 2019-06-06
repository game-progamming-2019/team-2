extends Node2D

signal level_complete
export var CAMERASPEED: float

func _ready():
	$Path2D/CameraPath.loop = false
	pass

func _process(delta):
	$Path2D/CameraPath.set_offset($Path2D/CameraPath.get_offset() + delta * CAMERASPEED)


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		emit_signal("level_complete")
