extends Node2D

# when the player presses shoot, send a word in that direction

@export var bullet_scn: PackedScene

@export var cooldown_base_sec: float = 1.8
var cooldown_remaining_sec: float = 0.0
@export var bullet_speed: float = 1500.0
@export var lifetime_sec: float = 1.2
@export var spread_degs: float = 70.0

@export var lines: Array[Line] = []

@onready var left: Node2D = get_node("Left")
@onready var right: Node2D = get_node("Right")
@onready var left_shoot: Node2D = get_node("Left/Shoot")
@onready var right_shoot: Node2D = get_node("Right/Shoot")

@onready var shoot_graphic_timer := Timer.new()

var markers: Array[Marker2D] = []

func _ready() -> void:
	for c in get_children():
		if c is Marker2D:
			markers.append(c)

	shoot_graphic_timer.one_shot = true
	shoot_graphic_timer.wait_time = cooldown_base_sec
	shoot_graphic_timer.connect("timeout", reset_shoot_graphic)
	add_child(shoot_graphic_timer)
	left_shoot.hide()
	right_shoot.hide()

func _process(delta: float) -> void:
	# point to mouse
	var mouse_world_pos := get_global_mouse_position()
	var gun_to_mouse := mouse_world_pos - global_position
	var angle_to_mouse := gun_to_mouse.angle()
	rotation = angle_to_mouse

	# toggle left or right graphics
	if abs(angle_to_mouse) > PI/2:
		left.show()
		right.hide()
	else:
		left.hide()
		right.show()

	# shoot automatically
	cooldown_remaining_sec -= delta
	if cooldown_remaining_sec <= 0.0:
		if Input.is_action_just_pressed("shoot"):
			shoot()

func shoot():
	cooldown_remaining_sec = cooldown_base_sec
	var line := lines.pick_random() as Line
	var degs := -spread_degs / 2.0
	var deg_step := spread_degs / (markers.size() - 1)
	for marker in markers:
		var bullet := bullet_scn.instantiate() as Node2D
		get_tree().get_current_scene().add_child(bullet)
		bullet.global_position = marker.global_position
		bullet.rotation = rotation + PI + deg_to_rad(degs)
		bullet.get_node("Mover").speed = bullet_speed
		bullet.get_node("LabelResizer").set_text(line.text)

		var auto_free_timer := Timer.new()
		auto_free_timer.wait_time = lifetime_sec
		auto_free_timer.autostart = true
		auto_free_timer.connect("timeout", bullet.queue_free)
		add_child(auto_free_timer)

		degs += deg_step

	left_shoot.show()
	right_shoot.show()
	shoot_graphic_timer.start()

func reset_shoot_graphic():
	left_shoot.hide()
	right_shoot.hide()
	
		
