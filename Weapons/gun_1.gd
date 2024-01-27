extends Node2D

# when the player presses shoot, send a word in that direction

func _process(delta: float) -> void:
	check_for_input()
	
	
func check_for_input():
	if Input.is_action_just_pressed("ui_fi")
