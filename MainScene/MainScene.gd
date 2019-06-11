extends Node2D

func _ready():
	pass # Replace with function body.

func _on_Menu_start():
	var game = load("res://Environment/Environment.tscn").instance()
	add_child(game)
	print("Laden")



func _on_Menu_credits():
	var start = load("res://Credits/Credits.tscn").instance()
	add_child(start)
	