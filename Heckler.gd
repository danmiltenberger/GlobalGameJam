extends Node2D
class_name Heckler

# when told by the Handler, spawn the projectiles
# this node should handle the spawning of tomatoes, cabbages, and beer cans
# in different patterns

@onready var beer_can: PackedScene = preload("res://Projectiles/beer_can.tscn")
@onready var cabbage: PackedScene = preload("res://Projectiles/cabbage.tscn")
@onready var tomato: PackedScene = preload("res://Projectiles/tomato.tscn")

var standing_up: bool = false

func send_projectiles(pattern: String, number: int, type: String, spacing_sec: float):
	standing_up = true
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
		"line":
			send_line(number, proj_type, spacing_sec)
		"circle":
			send_circle(number, proj_type, spacing_sec)
		"sine":
			send_sinusoidal(number, proj_type, spacing_sec)
		_:
			print_debug("couldn't find pattern: ", pattern)
			send_line(number, proj_type, spacing_sec)

func send_line(number: int, proj: PackedScene, spacing_sec: float):
	# send one projectile after another in a vertical line going down the screen
	var projectile: Node2D
	for i in range(number):
		print_debug("sent projectile!", projectile)
		projectile = proj.instantiate()
		add_child(projectile)
		projectile.global_position = global_position
		await get_tree().create_timer(spacing_sec).timeout
	standing_up = false

func send_circle(number: int, proj: PackedScene, spacing_sec: float):
	var projectile : Projectile
	
	# divide 180 deg by the number of projectiles
	# counter clockwise from east
	var deg_each: float = 180 / number
	for i in range(number):
		# create and organize
		projectile = proj.instantiate()
		add_child(projectile)
		
		# assigning direction vectors
		var dir_y = 1		# positive is DOWN the screen
		var deg = deg_each*i + 180
		var dir_x = tan(deg_to_rad(deg))
		var dir = Vector2(dir_x, dir_y)
		projectile.direction = Vector2(dir_x, dir_y)
		await get_tree().create_timer(spacing_sec).timeout
	standing_up = false

func send_sinusoidal(number: int, proj: PackedScene, spacing_sec: float):
	var projectile: Projectile
	var amplitude: float = 1000 # pixels
	var angle_spacing : int = 30
	for i in range(number):
		# create and organize
		projectile = proj.instantiate()
		add_child(projectile)
		
		# the direction (down) doesn't change, but the position does
		projectile.position.x = amplitude * sin(deg_to_rad(angle_spacing * i))
		
		await get_tree().create_timer(spacing_sec).timeout
	standing_up = false
