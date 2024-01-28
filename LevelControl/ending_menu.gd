extends Node2D



func _on_replay_button_down() -> void:
	var index = Globals.current_level
	Scn.change("level_"+str(index))



func _on_next_level_button_down() -> void:
	Globals.current_level += 1
	var index = Globals.current_level
	Scn.change("level_"+str(index))



func _on_main_menu_button_down() -> void:
	Scn.change("title_screen")
