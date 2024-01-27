extends Node2D
class_name Level

# handles all the projectiles and stuff which is shared between different levels

@onready var heckler_handler: HecklerHandler = $Projectiles/HecklerHandler


func _ready() -> void:
	heckler_handler.send_projectiles("sine", 30, "beer_can", 0.6)
