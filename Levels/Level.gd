extends Node2D
class_name Level

@export var csv_str: String = "level_1"
@export var repetitions: int = 4

@onready var heckler_handler: HecklerHandler = $HecklerHandler

func _ready() -> void:
	heckler_handler.load_csv(csv_str, repetitions)
	Globals.health = 100
	Globals.game_over = false

func _process(delta):
	# Decay health 1:1 with time
	Globals.health = max(Globals.health - delta, 0.0)

