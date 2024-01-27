class_name Mover extends Node

@export var speed := 1500

@onready var parent = get_parent() as Node2D

func _process(delta):
	var dir := Vector2(cos(parent.rotation), sin(parent.rotation))
	parent.position += dir * speed * delta