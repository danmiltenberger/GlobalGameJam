extends Node2D

class_name HurtboxHealthComponent

signal died

@export var max_health: int = 100
@export var gets_killed: bool = true
@export var gets_knockback: bool = true
@export var gets_stunned: bool = true
@export var hurt_box: Area2D
@export var sprite : CanvasItem



var current_health: int

@onready var parent = $".".get_parent()

func _ready():
	current_health = max_health
	
func _process(_delta):
	# always check and see if the creature should be dead
	if gets_killed and current_health <= 0:
		is_dead()

func hit(atk: int):
	current_health = max(current_health - atk, 0.0)
	print("took damage: ", atk)
	
	# start by checking if the entity should be killed
	if (gets_killed) and (current_health <= 0):
		is_dead()

func is_dead():
	parent.queue_free()
