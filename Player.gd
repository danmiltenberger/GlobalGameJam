extends CharacterBody2D
class_name Player


# left and right bounds for the player
@export var stage_left: int = 50
@export var stage_right : int = 1000
@export var stage_top: int = 1980 - 300
@export var stage_bot: int = 1980 - 100
@export var speed: int = 500
@export var health: int = 100

@onready var inspect_component: InspectComponent = $InspectComponent


func _process(_delta: float) -> void:
	move()
	check_off_stage()
	var inspect_dict: Dictionary = {
		"Health" : health
	}
	inspect_component.display(inspect_dict)

func move():
	var direction = Input.get_vector("ui_left","ui_right","ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()

func check_off_stage():
	if position.x <= stage_left:
		position.x = stage_left
		
	if position.x >= stage_right:
		position.x = stage_right
		
	if position.y <= stage_top:
		position.y = stage_top
		
	if position.y >= stage_bot:
		position.y = stage_bot
		
func take_damage(damage: int):
	health -= damage

