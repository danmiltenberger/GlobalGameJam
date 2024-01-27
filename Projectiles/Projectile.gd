extends Node2D
class_name Projectile

# this is the beer cans, tomatoes, etc that move down the screen

@export var speed: int = 100
@export var damage: int = 10
@export var health: int = 100

@onready var AOE_tracker: AreaTrackerComponent = $AreaOfEffectTracker

func hit(atk: int):
	$HurtboxHealthComponent.hit(atk)

func _process(delta: float) -> void:
	move_down_screen(delta)
	for body in AOE_tracker.tracked_bodies_list:
		if body is Player:
		#	print_debug("projectile collision!")
			body.take_damage(damage)
			destroy()
		#elif body is PlayerProjectile:
			#destroy()
	
func move_down_screen(delta):
	position.y += speed * delta

func destroy():
	#TODO - play a destroy animation?
	queue_free()
