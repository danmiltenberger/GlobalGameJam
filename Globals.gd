extends Node

# overall conditions like paused, dev mode, etc

var dev_mode: bool = true

var game_paused: bool = false

var health: float = 100.0:
	get:
		return health
	set(value):
		health = value
		return health

var currentGunIndex := 0
	
var jokes_landed: int = 0		# how many times a word hit a tomato
var total_damage_taken: int = 0	# tracks how much damage
var total_healing_taken: int = 0	# tracks how much healing (water bottles)

func play_sound_once(sound: AudioStream):
	var player := AudioStreamPlayer.new()
	player.stream = sound
	get_tree().get_root().add_child(player)
	player.play()
	player.connect("finished", player.queue_free)
