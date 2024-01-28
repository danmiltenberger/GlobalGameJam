extends Node2D
class_name Projectile

# this is the beer cans, tomatoes, etc that move down the screen

@export var speed: int = 500
@export var damage: int = 10
@export var health: int = 100

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
			destroy()
		elif body is Word:		# if it hits a player's words
			body.queue_free()	#TODO - do we like this behavior?
			destroy()
	
func move_down_screen(delta):
	position += speed * direction.normalized() * delta



func destroy():
	#TODO - play a destroy animation?
	queue_free()
