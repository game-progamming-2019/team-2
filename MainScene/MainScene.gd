extends Node2D

func _ready():
	pass # Replace with function body.

func _on_Menu_start():
	var welt = load("res://Environment/Environment.tscn").instance()
	add_child(welt)
	print("Laden")



func _on_Menu_credits():
	var welt = load("res://Credits/Credits.tscn").instance()
	add_child(welt)
	