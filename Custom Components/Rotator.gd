@tool
class_name Rotator extends Node

@export var preview = false
@export var do_ping_pong = false
@export_range(0, 720, 5, "or_greater", "or_less") var degs_if_ping_pong := 90.0
@export_range(0, 720, 5, "or_greater", "or_less") var speed := 75.0

var dir := 1.0
var val := 0.0

@onready var parent = get_parent() as Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _notification(what):
	if what == Node.NOTIFICATION_EDITOR_PRE_SAVE:
		parent.rotation -= deg_to_rad(val)
		print("%s -- %s" % [val, rad_to_deg(parent.rotation)])
		val = 0.0
		preview = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	parent.rotation -= deg_to_rad(val)
	if Engine.is_editor_hint() && !preview:
		val = 0.0
		return
	if do_ping_pong:
		val += dir * speed * delta
		if val > degs_if_ping_pong / 2:
			val = degs_if_ping_pong / 2
			dir = -1.0
		elif val < -degs_if_ping_pong / 2:
			val = -degs_if_ping_pong / 2
			dir = 1.0
	else:
		val += speed * delta
	parent.rotation += deg_to_rad(val)
	pass
