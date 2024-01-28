extends Node2D
class_name Heckler

# when told by the Handler, spawn the projectiles
# this node should handle the spawning of tomatoes, cabbages, and beer cans
# in different patterns

# projectiles
@onready var beer_can: PackedScene = preload("res://Projectiles/beer_can.tscn")
@onready var cabbage: PackedScene = preload("res://Projectiles/cabbage.tscn")
@onready var tomato: PackedScene = preload("res://Projectiles/tomato.tscn")
@onready var water_bottle: PackedScene = preload("res://Projectiles/water_bottle.tscn")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animator: AnimationPlayer = $Animator


@export var total_heckler_num: int = 6
var standing_up: bool = false

@onready var timer : Timer = Timer.new()

func _ready():
	pick_random_heckler_icon()
	pop_down()
	#sprite_2d.visible = false
	add_child(timer)

func pick_random_heckler_icon():
	var num = randi_range(1,total_heckler_num)
	#	"res://Graphics/HecklerIcons/Heckler2.png"
	var path_str = "res://Graphics/HecklerIcons/Heckler" + str(num) + ".png"
	#printt("num", num, "rand heckler path", path_str)
	sprite_2d.texture = load(path_str)

#func _process(_delta: float) -> void:
	#if standing_up:
		#sprite_2d.visible = true
	#else:
		#sprite_2d.visible = false

func send_projectiles(pattern: String, number: int, type: String, spacing_sec: float):
	printt(pattern, number, type, spacing_sec)
	standing_up = true
	var proj_type : PackedScene
	match type:
		"tomato":
			proj_type = tomato
		"cabbage":
			proj_type = cabbage
		"beer_can":
			proj_type = beer_can
		"water_bottle":
			proj_type = water_bottle
		_:
			print_debug("unexpected projectile type: ", type)
			proj_type = tomato

	match pattern:
		"line":
			pop_up()
			send_line(number, proj_type, spacing_sec)
		"circle":
			pop_up()
			send_circle(number, proj_type, spacing_sec)
		"sine":
			pop_up()
			send_sinusoidal(number, proj_type, spacing_sec)
		_:
			print_debug("couldn't find pattern: ", pattern)
			pop_up()
			send_line(number, proj_type, spacing_sec)

func send_line(number: int, proj: PackedScene, spacing_sec: float):
	# send one projectile after another in a vertical line going down the screen
	var projectile: Node2D
	for i in range(number):
		#print_debug("sent projectile!", projectile)
		projectile = proj.instantiate()
		$'.'.add_child(projectile)
		projectile.global_position = global_position
		timer.start(spacing_sec)
		timer.one_shot = true
		await timer.timeout
	pop_down()

func send_circle(number: int, proj: PackedScene, spacing_sec: float):
	var projectile : Projectile
	
	# divide 180 deg by the number of projectiles
	# counter clockwise from east
	var deg_each: float = 180.0 / number
	for i in range(number):
		# create and organize
		projectile = proj.instantiate()
		$'.'.add_child(projectile)
		
		# assigning direction vectors
		var dir_y = 1		# positive is DOWN the screen
		var deg = deg_each*i + 180
		var dir_x = tan(deg_to_rad(deg))
		var dir = Vector2(dir_x, dir_y)
		projectile.direction = dir
		timer.start(spacing_sec)
		timer.one_shot = true
		await timer.timeout
	pop_down()

func send_sinusoidal(number: int, proj: PackedScene, spacing_sec: float):
	var projectile: Projectile
	var amplitude: float = 1500 # pixels
	var angle_spacing : int = 30
	for i in range(number):
		# create and organize
		projectile = proj.instantiate()
		$'.'.add_child(projectile)
		
		# the direction (down) doesn't change, but the position does
		projectile.position.x = amplitude * sin(deg_to_rad(angle_spacing * i))
		
		timer.start(spacing_sec)
		await timer.timeout
	pop_down()

func pop_up():
	# move the position up
	animator.play_backwards("pop_down")
	#print_debug("heckler popping up")
	
func pop_down():
	# hide behind the row
	animator.play("pop_down")
	#print_debug("heckler popping down")
