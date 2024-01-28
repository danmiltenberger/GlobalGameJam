extends Node2D



func _on_start_game_button_down() -> void:

	Scn.change("level_1")
	Globals.play_sound_once_by_path("res://Audio/Curtain Slides Open (game begins).mp3")
	Globals.play_sound_once_by_path("res://Audio/heckler sounds/applause (GAME BEGINS).mp3", -1, -5)
	
	
