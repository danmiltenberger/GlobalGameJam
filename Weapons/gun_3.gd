extends Node2D

# when the player presses shoot, send a word in that direction

@export var bullet_scn: PackedScene
@export var is_right := true

@export var cooldown_base_sec: float = 0.2
var cooldown_remaining_sec: float = 0.0
@export var bullet_speed: float = 1500.0
@export var lifetime_sec: float = 1.2

@export var lines: Array[Line] = []
var lines_shuffled: Array[Line] = []

var current_line: Line = null
var words: Array[String] = []

@onready var marker: Marker2D = get_node("InstancePoint")
@onready var left: Node2D = get_node("Left")
@onready var right: Node2D = get_node("Right")
@onready var left_shoot: Node2D = get_node("Left/Shoot")
@onready var right_shoot: Node2D = get_node("Right/Shoot")

@onready var shoot_graphic_timer := Timer.new()

func _ready() -> void:
	shoot_graphic_timer.one_shot = true
	shoot_graphic_timer.connect("timeout", reset_shoot_graphic)
	add_child(shoot_graphic_timer)
	left_shoot.hide()
	right_shoot.hide()

func _process(delta: float) -> void:
	# toggle left or right graphics
	if is_right:
		left.hide()
		right.show()
	else:
		left.show()
		right.hide()

	# shoot
	if current_line == null:
		if Input.is_action_just_pressed("shoot") && !Globals.stuckFiring:
			shoot()
	
	# automatic shoot whole line
	if current_line != null:
		cooldown_remaining_sec -= delta
		if cooldown_remaining_sec <= 0.0:
			var word = words.pop_front()
			if words.size() == 0:
				current_line = null
				Globals.stuckFiring = false
			
			cooldown_remaining_sec = cooldown_base_sec * word.length() / 4.0
			if word == "...":
				cooldown_remaining_sec *= 2.0
			
			var bullet := bullet_scn.instantiate() as Node2D
			SceneSwitcher.current_level.add_child(bullet)
			bullet.global_position = marker.global_position
			bullet.rotation = global_rotation + PI
			bullet.get_node("Mover").speed = bullet_speed
			bullet.get_node("LabelResizer").set_text(word)
		
			var auto_free_timer := Timer.new()
			add_child(auto_free_timer)
			auto_free_timer.process_mode = Node.PROCESS_MODE_ALWAYS
			auto_free_timer.connect("timeout", bullet.queue_free)
			auto_free_timer.connect("timeout", auto_free_timer.queue_free)
			auto_free_timer.wait_time = lifetime_sec
			auto_free_timer.start()

			left_shoot.show()
			right_shoot.show()
			shoot_graphic_timer.wait_time = cooldown_remaining_sec * 0.75
			shoot_graphic_timer.start()

func shoot():
	cooldown_remaining_sec = 0
	if lines_shuffled.size() == 0:
		lines_shuffled.append_array(lines)
		lines_shuffled.shuffle()
	var line: Line = lines_shuffled.pop_front()

	current_line = line
	words.clear()
	for w in line.text.split("|"):
		words.append(w)
	Globals.play_sound_once(line.audio)
	Globals.stuckFiring = true

	Globals.play_sound_once_by_path("res://Audio/gun sounds/machine gun (non loop).mp3", 3.0, -16.0)

func reset_shoot_graphic():
	left_shoot.hide()
	right_shoot.hide()
		