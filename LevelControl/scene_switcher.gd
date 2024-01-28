extends Node2D
class_name SceneSwitcher
# The purpose of this node is to:
# 1. load the next level
# 2. close the previous level when it is "cleaned up" (sounds done etc)
# 3. show a loading screen to hide the harsh transitions
# 4. Optionally, show a progress bar

@export var starter_scene_str : String = "title_screen"
@onready var animator: AnimationPlayer = $AnimationPlayer


var current_level: Node2D

func _ready():
	#print("scene switcher: activating")
	create_starter_level()


func create_starter_level():
	# get and build the file
	var file_path_str = build_file_path(starter_scene_str)
	var starter_level = load(file_path_str)	#TODO - fix this line
	current_level = starter_level.instantiate()
	current_level.process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child(current_level)
	
	
	# when everything is ready, show the player and unpause
	fade_from_black()
	#get_tree().paused = true
	#await animator.animation_finished
	#get_tree().paused = false


func change(next_scene_str: String):
	#print("Scene Switch: Change Level Called")
	#print(next_scene_str)
	var file_path_str = build_file_path(next_scene_str)
	var next_level = load(file_path_str)
	print_debug("changing to:", file_path_str)
	
	
	# clean up the previous level
	curtain_close()
	pause()
	# get rid of the level
	current_level.queue_free()
	
	
	# the new one is now the current one
	current_level = next_level.instantiate()
	current_level.process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child(current_level)
	get_tree().paused = true


	await animator.animation_finished
	curtain_open()
	await animator.animation_finished
	get_tree().paused = false

func pause():
	print_debug("paused current level:", current_level)
	curtain_close()
	await animator.animation_finished
	get_tree().paused = true

func unpause():
	print_debug("unpaused current level:", current_level)
	curtain_open()
	await animator.animation_finished
	get_tree().paused = false
	
var is_paused: bool
func toggle_pause():
	# swap
	is_paused = not get_tree().paused
	
	# use swapped value
	printt("toggle pause: is_paused = ", is_paused)
	if is_paused:
		curtain_close()
	else:
		curtain_open()
	await animator.animation_finished
	get_tree().paused = is_paused


func build_file_path(level_str: String) -> String:
	var file_path_str: String
	file_path_str = "res://Levels/" + level_str + ".tscn"
	return file_path_str
	
func fade_to_black():
	animator.play("fade_to_black")

func fade_from_black():
	animator.play("fade_from_black")

func fade_to_gray():
	animator.play("fade_to_gray")

func fade_from_gray():
	animator.play("fade_from_gray")

func curtain_close():
	animator.play("curtain_close")
	
func curtain_open():
	animator.play_backwards("curtain_close")
