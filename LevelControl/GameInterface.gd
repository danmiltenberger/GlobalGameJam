extends CanvasLayer


@onready var health: Label = $Health
@onready var health_bar: ColorRect = $HealthBar
@export var health_bar_gradient: Gradient

@onready var health_original := Globals.health * 1.5 # give some space for the bar to go up

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	# Health text
	#TODO - fix this? it's pretty bad but it works!
	# ^ it's fine, just better to store as float than int
	var minutes := floori(Globals.health / 60.0)
	var remainder := Globals.health / 60.0 - minutes
	var seconds := snappedi(remainder * 60, 1)
	var seconds_str: String
	if seconds < 10:
		seconds_str = "0" + str(seconds)
	else:
		seconds_str = str(seconds)
	var health_str: String = str(minutes) + ":" +  seconds_str
	health.text = health_str

	# Health bar
	var health_percent: float = clamp(Globals.health / health_original, 0, 1)
	health_bar.scale.x = health_percent
	health_bar.color = health_bar_gradient.sample(1 - health_percent)
