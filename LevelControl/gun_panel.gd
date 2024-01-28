class_name GunPanel extends PanelContainer

@export_range(0, 3) var gun_index := 0

@onready var button: Button = $Button

# Called when the node enters the scene tree for the first time.
func _ready():
	button.connect("pressed", _on_button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	button.disabled = Globals.currentGunIndex == gun_index

func _on_button_pressed():
	if !Globals.stuckFiring:
		Globals.setGunIndex(gun_index)
