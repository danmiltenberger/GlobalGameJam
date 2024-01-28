extends Node

# overall conditions like paused, dev mode, etc

var dev_mode: bool = true

var game_paused: bool = false

var health: int = 100:
	get:
		return health
	set(value):
		health = value
		return health
	
var jokes_landed: int = 0		# how many times a word hit a tomato
var total_damage_taken: int = 0	# tracks how much damage
var total_healing_taken: int = 0	# tracks how much healing (water bottles)
