extends Node

# overall conditions like paused, dev mode, etc

var dev_mode: bool = true

var game_paused: bool = false

var health:
	get:
		return health
	set(value):
		health = value
		return health
