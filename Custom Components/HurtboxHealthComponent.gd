extends Node2D

class_name HurtboxHealthComponent

signal died

@export var max_health: int = 100
@export var gets_killed: bool = true
@export var gets_knockback: bool = true
@export var gets_stunned: bool = true
@export var hurt_box: Area2D
@export var sprite : CanvasItem



var current_health: int

@onready var parent = $".".get_parent()

# set the flash red shader to the sprite

func _ready():
	current_health = max_health
	
func _process(_delta):
	# always check and see if the creature should be dead
	if gets_killed and current_health <= 0:
		is_dead()

func hit(atk: int):
	#print("hit!")
	flash_red()
	current_health -= atk
	print("took damage: ", atk)
	
	# start by checking if the entity should be killed
	if (gets_killed) and (current_health <= 0):
		is_dead()




func is_dead():
	print("entity should be dead?")
	died.emit()
	print("emitted 'died' signal")
	parent.queue_free()

func flash_red():
	print("flash red")
	
	# TODO - fix this so it actually works
	#var time_between_flashes = 0.3
	#var flash_duration = 0.1
	#var num_of_flashes: int = 1
	#
	##TODO this probably isn't very efficient
	#print("sprite: ", sprite)
	#sprite.material.shader = flash_red_shader
	#
	#for i in num_of_flashes:
		##print("flashing red")
		#sprite.material.set_shader_parameter("active", true)
		#await get_tree().create_timer(flash_duration).timeout
#
		##print("returning to original color")
		#sprite.material.set_shader_parameter("active", false)
		#
		#await get_tree().create_timer(time_between_flashes).timeout
