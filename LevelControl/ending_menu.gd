extends Node2D

func _ready() -> void:
	show_ending_statistics()

func show_ending_statistics():
	var jokes = Globals.jokes_landed
	var damage = Globals.total_damage_taken
	var healing = Globals.total_healing_taken
	printt(jokes, damage, healing)
	$GridContainer/JokeFloat.text = str(jokes)
	$GridContainer/DamageFloat.text = str(damage)
	$GridContainer/HealingFloat.text = str(healing)
	
func clear_ending_statistics():
	Globals.jokes_landed = 0
	Globals.total_damage_taken = 0
	Globals.total_healing_taken = 0

func _on_replay_button_down() -> void:
	var index = Globals.current_level
	Scn.change("level_"+str(index))
	clear_ending_statistics()



func _on_next_level_button_down() -> void:
	Globals.current_level += 1
	var index = Globals.current_level
	Scn.change("level_"+str(index))



func _on_main_menu_button_down() -> void:
	Scn.change("title_screen")
