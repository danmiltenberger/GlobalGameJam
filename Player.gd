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


func _process(delta: float) -> void:
	# move
	var direction = Input.get_vector("ui_left","ui_right","ui_up", "ui_down")
	velocity = direction * speed
	position += velocity * delta

	# clamp to stage
	position.x = clamp(position.x, stage_left, stage_right)
	position.y = clamp(position.y, stage_top, stage_bot)

	# health
	var inspect_dict: Dictionary = {
		"Health" : health
	}
	inspect_component.display(inspect_dict)
		
func take_damage(damage: int):
	health -= damage

