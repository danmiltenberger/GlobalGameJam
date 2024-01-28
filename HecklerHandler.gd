extends Node2D
class_name HecklerHandler
@export var repetitions: int = 10
@export var level_csv_str: String = "level_1"
# take a csv with defined paramters, pass to individual hecklers
# the individual hecklers are children

var is_ready: bool = false
var csv: Array
var timer: Timer
var activated : bool = false
	
func load_csv(csv_given_str: String = "level_1", given_repetitions: int = 4):
	var csv_str = "res://LevelPatterns/" + csv_given_str + ".csv"
	print_debug(csv_str)
	csv = load(csv_str).records
	timer = Timer.new()
	add_child(timer)
	is_ready = true
	repetitions = given_repetitions

func _process(_delta: float) -> void:
	if is_ready:
		if activated == false:
			activated = true
			for i in range(repetitions):
				for line in csv:
					var dispatch_interval_sec: float = float(line["dispatch_interval_sec"])
					interpret_dict(line)
					timer.start(dispatch_interval_sec)
					#print_debug("awaiting timer timeout")
					await timer.timeout

func get_heckler(row: int, col: int) -> Heckler:
	var path: String = "Row"+str(row) +"/Heckler"+str(col)
	var heckler: Heckler = get_node(path)
	#print_debug(path)
	return heckler


func interpret_dict(dict: Dictionary):
	var row: int = int(dict["row"])
	var col: int = int(dict["col"])
	var pattern: String = dict["pattern"]
	var number: int = int(dict["number"])
	var type: String = dict["type"]
	var spacing_sec: float = float(dict["spacing_sec"])
	var heckler = get_heckler(row, col)
	heckler.send_projectiles(pattern, number, type, spacing_sec)


