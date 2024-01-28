extends CanvasLayer

@onready var health: Label = $Health
@onready var timer : Timer 

func _ready() -> void:
	timer = Timer.new()
	timer.one_shot = false
	add_child(timer)
	timer.start(1)
	timer.timeout.connect(count_seconds)
	
	

func _process(_delta: float) -> void:

	health_is_time()

func health_is_time():
	#TODO - fix this? it's pretty bad but it works!
	@warning_ignore("integer_division")
	var minutes = Globals.health / 60
	var remainder = Globals.health / 60.0 - minutes
	var seconds = snappedi(remainder * 60, 1)
	var seconds_str: String
	if seconds < 10:
		seconds_str = "0" + str(seconds)
	else:
		seconds_str = str(seconds)
	var health_str: String = str(minutes) + ":" +  seconds_str
	health.text = health_str

func count_seconds():
	print("timer done")
	Globals.health -= 1
