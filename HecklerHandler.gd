extends Node2D
class_name HecklerHandler
@export var repetitions: int = 10
# take a csv with defined paramters, pass to individual hecklers
# the individual hecklers are children
func _ready() -> void:
	var csv = preload("res://LevelControl/heckler_spawning_list.csv").records
	for i in range(repetitions):
		for line in csv:
			var dispatch_interval_sec: float = interpret_dict(line)
			


func get_heckler(row: int, col: int) -> Heckler:
	var path: String = "Row"+str(row) +"/Heckler"+str(col)
	var heckler: Heckler = get_node(path)
	#print_debug(path)
	return heckler


func interpret_dict(dict: Dictionary) -> float:
	var row: int = dict["row"]
	var col: int = dict["col"]
	var pattern: String = dict["pattern"]
	var number: int = dict["number"]
	var type: String = dict["type"]
	var spacing_sec: float = dict["spacing_sec"]
	var dispatch_interval_sec: float = dict["dispatch_interval_sec"]
	var heckler = get_heckler(row, col)
	heckler.send_projectiles(pattern, number, type, spacing_sec)
	return dispatch_interval_sec

