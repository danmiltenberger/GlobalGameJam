extends Node2D

# handles pausing and "dev inspecting"
@export var scene_control: SceneSwitcher
@onready var pause_menu : CanvasLayer = $PauseMenu

func _ready() -> void:
	close_all_menus()

func _process(_delta: float) -> void:
	player_pause_unpause()
	game_over()

func close_all_menus():
	$PauseMenu.visible = false
	$SettingsMenu.visible = false
	$MainMenu.visible = false
	$EndingMenu.visible = false

func player_pause_unpause():
	if Input.is_action_just_pressed("pause"):
		#print_debug("paused toggled!")
		# toggle
		Scn.toggle_pause()


func game_over():
	if Globals.health <= 0:
		Scn.pause()
		$EndingMenu.visible = true

func _on_settings_button_button_down() -> void:
	close_all_menus()
	$SettingsMenu.visible = true



func _on_main_menu_button_down() -> void:
	close_all_menus()
	$MainMenu.visible = true
