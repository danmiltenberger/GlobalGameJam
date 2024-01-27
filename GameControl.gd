extends Node2D

# handles pausing and "dev inspecting"
@export var scene_control: SceneSwitcher
@onready var paused_label: Label = $PausedLabel

func _process(_delta: float) -> void:
	player_pause_unpause()

func player_pause_unpause():
	if Input.is_action_just_pressed("pause"):
		print_debug("paused toggled!")
		Globals.game_paused = not Globals.game_paused
		
	if Globals.game_paused == true:
		paused_label.visible = true
		control_current_level(true)
	else:
		paused_label.visible = false
		control_current_level(false)


func control_current_level(paused: bool):
	scene_control.get_tree().paused = paused
	
	
