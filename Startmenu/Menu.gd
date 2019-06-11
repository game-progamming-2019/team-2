extends Node2D

signal start
signal credits

func _ready():
	pass # Replace with function body.

func _on_Start_pressed():
	emit_signal("start")
	print("start")
	queue_free()
	



func _on_Credits_pressed():
	emit_signal("credits")
	print("credits")
	queue_free()
	
