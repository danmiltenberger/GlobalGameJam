extends Node2D
class_name Projectile

# this is the beer cans, tomatoes, etc that move down the screen

@export var speed: int = 100
@export var damage: int = 10

@onready var area_tracker: AreaTrackerComponent = $AreaTrackerComponent


func _process(delta: float) -> void:
	move_down_screen(delta)
	for body in area_tracker.tracked_bodies_list:
		if body is Player:
			print_debug("projectile collision!")
			body.take_damage(damage)
			destroy()
	
func move_down_screen(delta):
	position.y += speed * delta

func destroy():
	#TODO - play a destroy animation?
	queue_free()
