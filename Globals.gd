extends Node

# overall conditions like paused, dev mode, etc

var dev_mode: bool = true

var health: float = 100.0:
	get:
		return health
	set(value):
		health = value
		return health

var currentGunIndex := 0
var previousGunIndex := 0
func setGunIndex(index: int):
	if currentGunIndex == index:
		return
	previousGunIndex = currentGunIndex
	currentGunIndex = index

var stuckFiring := false
	
var jokes_landed: int = 0		# how many times a word hit a tomato
var total_damage_taken: int = 0	# tracks how much damage
var total_healing_taken: int = 0	# tracks how much healing (water bottles)

#region Settings
#TODO - change this to true, but for testing it's quite
var play_sound: bool = true

#endregion


func play_sound_once(sound: AudioStream, volume := 0.0):
	if play_sound:
		var player := AudioStreamPlayer.new()
		player.volume_db = volume
		player.stream = sound
		get_tree().get_root().add_child(player)
		player.play()
		player.connect("finished", player.queue_free)

func play_sound_once_by_path(path: String, sec := -1.0, volume := 0.0):
	if play_sound:
		var player := AudioStreamPlayer.new()
		player.volume_db = volume
		var sound := load(path) as AudioStream
		player.stream = sound
		get_tree().get_root().add_child(player)
		player.play()
		if sec > 0:
			player.connect("finished", player.queue_free)
			await get_tree().create_timer(sec).timeout
			player.queue_free()
		
		
var current_level: int = 1
var game_over: bool = false
