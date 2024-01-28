extends CharacterBody2D
class_name Player

# left and right bounds for the player
@export var stage_left: int = 50
@export var stage_right : int = 1000
@export var stage_top: int = 1980 - 300
@export var stage_bot: int = 1980 - 100
@export var speed: int = 500

@onready var inspect_component: InspectComponent = $InspectComponent
@onready var arm: Node2D = $Arm
@export var base_arm_degs := -75.0

@onready var gun1: Node2D = $Arm/Gun1
@onready var gun2: Node2D = $Arm/Gun2
@onready var gun3: Node2D = $Arm/Gun3
@onready var gun4: Node2D = $Arm/Gun4
@onready var guns = [gun1, gun2, gun3, gun4]

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
	if !Globals.stuckFiring:
		if Input.is_action_just_pressed("weapon1"):
			Globals.setGunIndex(0)
		elif Input.is_action_just_pressed("weapon2"):
			Globals.setGunIndex(1)
		elif Input.is_action_just_pressed("weapon3"):
			Globals.setGunIndex(2)
		elif Globals.timeTo4 <= 0.0 && Input.is_action_just_pressed("weapon4"):
			Globals.setGunIndex(3)
		update_gun()

	# aim at mouse
	var mouse_world_pos := get_global_mouse_position()
	var arm_to_mouse := mouse_world_pos - arm.global_position
	var angle_to_mouse_raw := arm_to_mouse.angle()
	var is_right = abs(angle_to_mouse_raw) < PI/2
	#print_debug(is_right)
	arm.global_rotation = angle_to_mouse_raw + deg_to_rad(base_arm_degs if is_right else -base_arm_degs)
	arm.scale.y = 1 if is_right else -1
	guns[Globals.currentGunIndex].is_right = is_right

	# health
	#var inspect_dict: Dictionary = {
		#"Health" : health
	#}
	#inspect_component.display(inspect_dict)

func update_gun():
	for gun in guns:
		gun.hide()
		gun.process_mode = Node.PROCESS_MODE_DISABLED
	guns[Globals.currentGunIndex].show()
	guns[Globals.currentGunIndex].process_mode = Node.PROCESS_MODE_INHERIT
		
func take_damage(damage: int):
	Globals.health = max(Globals.health - damage, 0.0)

