class_name Mover extends Node

@export var speed := 1500.0
@export_range(-180, 180, 0.1, "degrees") var rotation_offset := 0.0

@onready var parent = get_parent() as Node2D

func _process(delta):
	var dir := Vector2(cos(parent.rotation + deg_to_rad(rotation_offset)), sin(parent.rotation + deg_to_rad(rotation_offset)))
	parent.position += dir * speed * delta