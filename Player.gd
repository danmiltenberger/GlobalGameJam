extends CharacterBody2D
class_name Player


# left and right bounds for the player
@export var stage_left: int = 50
@export var stage_right : int = 500
@export var speed: int = 500

func _process(delta: float) -> void:
	move()
	check_off_stage()
	
	
func move():
	var direction = Input.get_vector("ui_left","ui_right","ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()

func check_off_stage():
	if position.x <= stage_left:
		position.x = stage_left
	elif position.x >= stage_right:
		position.x = stage_right
	
