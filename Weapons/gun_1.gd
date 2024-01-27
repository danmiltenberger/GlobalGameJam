extends Node2D

# when the player presses shoot, send a word in that direction

var cooldown_sec_left: float
var can_shoot: bool = true
@onready var timer = Timer.new()

func _ready() -> void:
	print_debug("gun 1 ready")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		print_debug("shoot action pressed!")
		shoot("word")


func shoot(bullet_str: String):
	var bullet  = load("res://Projectiles/" + bullet_str + ".tscn")
	bullet.instantiate() 
	

func cooldown_timer(seconds):
	timer.wait_time = seconds
	timer.one_shot = true
	timer.start()
	cooldown_sec_left = timer.time_left
	
	
func cooldown_timer_timeout():
	can_shoot = true
