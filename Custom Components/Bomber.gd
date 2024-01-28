class_name Bomber extends Node

@export var bullet_scn: PackedScene
@export var num_bullets: int = 24
@export var target_pos: Vector2
@export var text: String
@export var speed: float = 800.0
@export var lifetime: float = 1.2

@onready var parent = get_parent() as Node2D
@onready var original_pos = parent.global_position

func _ready():
	parent.connect("tree_exiting", explode)

func explode():
	for i in range(num_bullets):
		var bullet := bullet_scn.instantiate() as Node2D
		bullet.global_position = parent.global_position
		bullet.rotation = i * 2.0 * PI / num_bullets
		bullet.position += Vector2(cos(bullet.rotation) * 4.0, sin(bullet.rotation) * 4.0)
		bullet.get_node("Mover").speed = speed
		bullet.get_node("LabelResizer").set_text(text)
		get_parent().get_parent().get_parent().add_child(bullet)

		var auto_free_timer := Timer.new()
		get_parent().get_parent().get_parent().add_child(auto_free_timer)
		auto_free_timer.process_mode = Node.PROCESS_MODE_ALWAYS
		auto_free_timer.connect("timeout", bullet.queue_free)
		auto_free_timer.connect("timeout", auto_free_timer.queue_free)
		auto_free_timer.wait_time = lifetime
		auto_free_timer.start()
