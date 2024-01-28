extends Node2D
class_name Projectile

# this is the beer cans, tomatoes, etc that move down the screen

@export var speed: int = 500
@export var damage: int = 10
@export var health: int = 100
@export var sound: AudioStream

@onready var collision_area: AreaTrackerComponent = $CollisionArea

var direction: Vector2 = Vector2.DOWN

func hit(atk: int):
	$HurtboxHealthComponent.hit(atk)

func _process(delta: float) -> void:
	move_down_screen(delta)
	for body in collision_area.tracked_bodies_list:
		if body is Player:		# if it hits the player
		#	print_debug("projectile collision!")
			body.take_damage(damage)
			if damage >= 0:
				Globals.total_damage_taken += damage
			else:
				Globals.total_healing_taken -= damage
			Globals.jokes_landed += 1
			Globals.play_sound_once(sound)
			destroy()
		elif body is Word:		# if it hits a player's words
			body.get_node("Label/ColorRect").visible = false
			body.get_node("Label").modulate = Color(1, 1, 1, 0.7)
			(body as StaticBody2D).collision_layer = 0
			destroy()
	
func move_down_screen(delta):
	position += speed * direction.normalized() * delta



func destroy():
	#TODO - play a destroy animation?
	queue_free()
