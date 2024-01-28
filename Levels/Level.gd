extends Node2D
class_name Level

@onready var heckler_handler: HecklerHandler = $HecklerHandler

func _ready() -> void:
	heckler_handler.level_csv = "level_1__version_1_-mazza"





func _process(delta):
	# Decay health 1:1 with time
	Globals.health -= delta


