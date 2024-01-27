extends Node2D

@export var speed := 2.0

@onready var auto_free_timer := Timer.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	auto_free_timer.wait_time = 10.0
	auto_free_timer.autostart = true
	auto_free_timer.connect("timeout", queue_free)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir := Vector2(cos(rotation), sin(rotation))
	position += dir * speed * delta
