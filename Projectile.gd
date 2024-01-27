extends Node2D
class_name Projectile

# this is the beer cans, tomatoes, etc that move down the screen

@export var speed: int = 100

func _process(delta: float) -> void:
	move_down_screen(delta)
	
func move_down_screen(delta):
	position.y -= speed * delta
