extends Node2D
class_name SceneSwitcher
# The purpose of this node is to:
# 1. load the next level
# 2. close the previous level when it is "cleaned up" (sounds done etc)
# 3. show a loading screen to hide the harsh transitions
# 4. Optionally, show a progress bar

@export var starter_scene_str : String = "tutorial_2"

@onready var animator : AnimationPlayer = $AnimationPlayer

var current_level: Node2D

func _ready():
	#print("scene switcher: activating")
	create_starter_level()


func create_starter_level():
	# get and build the file
	var file_path_str = build_file_path(starter_scene_str)
	var starter_level = load(file_path_str)
	current_level = starter_level.instantiate()
	add_child(current_level)
	
	
	# when everything is ready, show the player and unpause
	fade_from_black()
	#current_level.get_tree().paused = true
	#await animator.animation_finished
	#current_level.get_tree().paused = false


func change(next_scene_str: String):
	#print("Scene Switch: Change Level Called")
	#print(next_scene_str)
	var file_path_str = build_file_path(next_scene_str)
	var next_level = load(file_path_str)
	print_debug("changing to:", file_path_str)
	# clean up the previous level
	fade_to_black()
	current_level.cleanup()
	
	# the new one is now the current one
	current_level = next_level.instantiate()
	add_child(current_level)
	
	# TODO - wait for transition to complete and then unpause
	fade_from_black()



func build_file_path(level_str: String) -> String:
	var file_path_str: String
	file_path_str = "res://Levels/" + level_str + ".tscn"
	return file_path_str
	
func fade_to_black():
	animator.play("fade_to_black")

func fade_from_black():
	animator.play("fade_from_black")



