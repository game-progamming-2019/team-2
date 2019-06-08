extends Area2D

### Gegner immer von die Klasse ableiten
class_name Enemy

# Wird aufgerufen wenn ein Gegner den Lichtkegel betritt.
func on_flashlight_start():
	print("on_flashlight_start() has not been overwritten")

# Wird aufgerufen wenn ein Gegner den Lichtkegel verlässt.
func on_flashlight_end():
	print("on_flashlight_end() has not been overwritten")

# Gegner müssen Area2D als Vaterknoten besitzen.
	# -> Spieler läuft durch Gegner