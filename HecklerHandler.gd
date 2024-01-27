extends Node2D
class_name HecklerHandler

# this node should handle the spawning of tomatoes, cabbages, and beer cans


func send_projectiles(pattern: String):
	match pattern:
		"Line":
			send_line()
		"Circle":
			send_circle()
		_:
			print_debug("couldn't find pattern: ", pattern)
			send_line()

func send_line():
	pass

func send_circle():
	pass
