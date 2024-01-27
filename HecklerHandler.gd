extends Node2D
class_name HecklerHandler
@export var repetitions: int = 10
# take a csv with defined paramters, pass to individual hecklers
# the individual hecklers are children

var activated: bool = false
var csv: Array
var timer: Timer

func _ready() -> void:
	csv = preload("res://LevelControl/heckler_spawning_list.csv").records
	timer = Timer.new()
	add_child(timer)

func _process(_delta: float) -> void:
	if activated == false:
		activated = true
		for i in range(repetitions):
			for line in csv:
				var dispatch_interval_sec: float = line["dispatch_interval_sec"]
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
	var row: int = dict["row"]
	var col: int = dict["col"]
	var pattern: String = dict["pattern"]
	var number: int = dict["number"]
	var type: String = dict["type"]
	var spacing_sec: float = dict["spacing_sec"]
	var heckler = get_heckler(row, col)
	heckler.send_projectiles(pattern, number, type, spacing_sec)


