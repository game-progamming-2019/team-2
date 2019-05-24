extends Area2D

## Emitted whenever a player collides with a coin
signal coin_collected

export var ANIMATE:bool = true
export var PLAYERNAME = ["Player", "Held", "Spieler"]


func _ready():
	if ANIMATE:
		$Sprite/AnimationPlayer.play("rotate")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for body in get_overlapping_bodies():
		if body.name in PLAYERNAME:
			emit_signal("coin_collected")
			queue_free()
			
		## Returns its own name
		#print(shape_owner_get_owner(body.get_shape_owners()[1]).get_parent().name)