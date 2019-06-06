extends Node2D

signal start

func _ready():
	pass # Replace with function body.

func _on_Start_pressed():
	emit_signal("start")
	print("start")
	queue_free()
	pass # Replace with function body.


