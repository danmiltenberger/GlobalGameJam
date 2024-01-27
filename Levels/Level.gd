extends Node2D
class_name Level

# handles all the projectiles and stuff which is shared between different levels

@onready var heckler_handler: HecklerHandler = $Projectiles/HecklerHandler

#func _ready() -> void:
	#read_csv()

#
#func read_csv():
	#var csv = preload("res://LevelControl/heckler_spawning_list.csv").resources
