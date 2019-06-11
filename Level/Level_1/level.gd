extends Node2D

signal level_complete
export var CAMERASPEED: float
export var NACHT: bool

func _ready():
	$Path2D/CameraPath.loop = false

func _process(delta):
	$Path2D/CameraPath.set_offset($Path2D/CameraPath.get_offset() + delta * CAMERASPEED)

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		emit_signal("level_complete")
