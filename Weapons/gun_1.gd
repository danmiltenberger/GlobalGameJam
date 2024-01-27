extends Node2D

# when the player presses shoot, send a word in that direction

@export var bullet_scn: PackedScene

@export var cooldown_base_sec: float = 0.2
var cooldown_remaining_sec: float = 0.0

@onready var marker: Marker2D = get_node("InstancePoint")

func _ready() -> void:
	print_debug("gun 1 ready")

func _process(delta: float) -> void:
	# point to mouse
	var mouse_world_pos := get_global_mouse_position()
	var gun_to_mouse := mouse_world_pos - global_position
	var angle_to_mouse := gun_to_mouse.angle()
	rotation = angle_to_mouse

	# shoot automatically
	cooldown_remaining_sec -= delta
	if cooldown_remaining_sec <= 0.0:
		if Input.is_action_pressed("shoot"):
			shoot()

func shoot():
	cooldown_remaining_sec = cooldown_base_sec
	var bullet := bullet_scn.instantiate()
	get_tree().get_current_scene().add_child(bullet)
	bullet.global_position = marker.global_position
	bullet.rotation = rotation
