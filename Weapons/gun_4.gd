extends Node2D

# when the player presses shoot, send a word in that direction

@export var bullet_scn: PackedScene
@export var is_right := true

@export var cooldown_base_sec: float = 0.2
var cooldown_remaining_sec: float = 0.0
@export var lifetime_sec: float = 1.2

@export var lines: Array[Line] = []
var lines_shuffled: Array[Line] = []

@onready var marker: Marker2D = get_node("InstancePoint")
@onready var left: Node2D = get_node("Left")
@onready var right: Node2D = get_node("Right")
@onready var left_shoot: Node2D = get_node("Left/Shoot")
@onready var right_shoot: Node2D = get_node("Right/Shoot")

func _ready() -> void:
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

	# shoot automatically
	cooldown_remaining_sec -= delta
	if cooldown_remaining_sec <= 0.0:
		if Input.is_action_just_pressed("shoot") && !Globals.stuckFiring:
			shoot()

func shoot():
	cooldown_remaining_sec = cooldown_base_sec

	if lines_shuffled.size() == 0:
		lines_shuffled.append_array(lines)
		lines_shuffled.shuffle()
	var line: Line = lines_shuffled.pop_front()

	var bullet := bullet_scn.instantiate() as Node2D
	get_tree().get_current_scene().add_child(bullet)
	bullet.global_position = marker.global_position
	bullet.rotation = global_rotation + PI
	var dist = (get_global_mouse_position() - bullet.global_position).length()
	bullet.get_node("Mover").speed = dist / line.timing
	bullet.get_node("LabelResizer").set_text(line.text.split("|")[0])
	bullet.get_node("Bomber").target_pos = get_global_mouse_position()
	bullet.get_node("Bomber").text = line.text.split("|")[1]
	Globals.play_sound_once(line.audio)

	var auto_free_timer := Timer.new()
	add_child(auto_free_timer)
	auto_free_timer.process_mode = Node.PROCESS_MODE_ALWAYS
	auto_free_timer.connect("timeout", bullet.queue_free)
	auto_free_timer.connect("timeout", auto_free_timer.queue_free)
	auto_free_timer.wait_time = line.timing
	auto_free_timer.start()

	var stuck_timer := Timer.new()
	add_child(stuck_timer)
	stuck_timer.process_mode = Node.PROCESS_MODE_ALWAYS
	stuck_timer.connect("timeout", _done_stuck)
	stuck_timer.connect("timeout", stuck_timer.queue_free)
	stuck_timer.wait_time = line.timing + bullet.get_node("Bomber").lifetime
	stuck_timer.start()
	Globals.stuckFiring = true

	left_shoot.show()
	right_shoot.show()

func _done_stuck():
	Globals.stuckFiring = false
	Globals.currentGunIndex = Globals.previousGunIndex