extends Node2D

# handles pausing and "dev inspecting"
@export var scene_control: SceneSwitcher
@onready var pause_menu : CanvasLayer = $PauseMenu

func _ready() -> void:
	close_all_menus()

func _process(_delta: float) -> void:
	player_pause_unpause()
	game_over()
	#$PauseMenu.visible = get_tree().paused



func close_all_menus():
	$PauseMenu.visible = false
	$SettingsMenu.visible = false
	$MainMenu.visible = false
	$EndingMenu.visible = false

func player_pause_unpause():
	if Input.is_action_just_pressed("pause"):
		Scn.toggle_pause()
		$PauseMenu.visible = Scn.is_paused



func game_over():
	if Globals.health <= 0:
		Scn.pause()
		$EndingMenu.visible = true

func _on_settings_button_button_down() -> void:
	close_all_menus()
	$SettingsMenu.visible = true



func _on_main_menu_button_down() -> void:
	close_all_menus()
	Scn.change("title_screen")

var is_spoken_jokes: bool = true
func _on_spoken_jokes_toggle_button_down() -> void:
	is_spoken_jokes = not is_spoken_jokes
	Globals.play_sound = is_spoken_jokes
	
