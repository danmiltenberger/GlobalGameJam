extends Node2D
class_name Level

func _process(delta):
	# Decay health 1:1 with time
	Globals.health -= delta
