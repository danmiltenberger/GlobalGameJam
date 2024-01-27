extends Node2D
class_name HecklerHandler

# this node should handle the spawning of tomatoes, cabbages, and beer cans


@onready var beer_can: PackedScene = preload("res://Projectiles/beer_can.tscn")
@onready var cabbage: PackedScene = preload("res://Projectiles/cabbage.tscn")
@onready var tomato: PackedScene = preload("res://Projectiles/tomato.tscn")


func send_projectiles(pattern: String, number: int, type: String):
	var proj_type : PackedScene
	match type:
		"tomato":
			proj_type = tomato
		"cabbage":
			proj_type = cabbage
		"beer_can":
			proj_type = beer_can
		_:
			print_debug("unexpected projectile type: ", type)
			proj_type = tomato

	match pattern:
		"Line":
			send_line(number, proj_type)
		"Circle":
			send_circle(number, proj_type)
		_:
			print_debug("couldn't find pattern: ", pattern)
			send_line(number, proj_type)

func send_line(number: int, proj: PackedScene):
	# send one projectile after another in a vertical line going down the screen
	var projectile: Node2D
	for i in range(number):
		projectile = proj.instantiate()
		projectile.global_position = global_position

	pass

func send_circle(number: int, proj: PackedScene):
	pass
