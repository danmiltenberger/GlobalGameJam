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

@onready var gun1: Node2D = $Gun1
@onready var gun2: Node2D = $Gun2
@onready var gun3: Node2D = $Gun3
@onready var guns = [gun1, gun2, gun3]
@onready var currentGun = gun1

func _ready():
	update_gun()

func _process(delta: float) -> void:
	# move
	var direction = Input.get_vector("ui_left","ui_right","ui_up", "ui_down")
	velocity = direction * speed
	position += velocity * delta

	# clamp to stage
	position.x = clamp(position.x, stage_left, stage_right)
	position.y = clamp(position.y, stage_top, stage_bot)

	# weapon switching
	if Input.is_action_just_pressed("weapon1"):
		currentGun = gun1
		update_gun()
	elif Input.is_action_just_pressed("weapon2"):
		currentGun = gun2
		update_gun()
	elif Input.is_action_just_pressed("weapon3"):
		currentGun = gun3
		update_gun()

	# health
	var inspect_dict: Dictionary = {
		"Health" : health
	}
	inspect_component.display(inspect_dict)

func update_gun():
	for gun in guns:
		gun.hide()
		gun.process_mode = Node.PROCESS_MODE_DISABLED
	currentGun.show()
	currentGun.process_mode = Node.PROCESS_MODE_INHERIT
		
func take_damage(damage: int):
	health -= damage

