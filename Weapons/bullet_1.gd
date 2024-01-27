extends Node2D
class_name Word
@export var speed := 2.0
@export var damage: int = 20

@onready var auto_free_timer := Timer.new()
@onready var collision_area: Area2D = $CollisionArea

# Called when the node enters the scene tree for the first time.
func _ready():
	auto_free_timer.wait_time = 10.0
	auto_free_timer.autostart = true
	auto_free_timer.connect("timeout", queue_free)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir := Vector2(cos(rotation), sin(rotation))
	position += dir * speed * delta

func collide(body: Node2D):
	if "hit" in body:
		body.hit(damage)
		

