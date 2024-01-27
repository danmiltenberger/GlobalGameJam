extends Node2D
class_name HecklerHandler



# take a csv with defined paramters, pass to individual hecklers
# the individual hecklers are children

func get_heckler(row: int, col: int) -> Heckler:
	var path: String = "Row"+str(row) +"/Heckler"+str(col)
	var heckler: Heckler = get_node(path)
	print_debug(path)
	return heckler

func _ready() -> void:
	var heckler = get_heckler(5,5)
	heckler.visible = false

func interpret_dict(dict: Dictionary):
	var row = dict["row"]
	var col = dict["col"]
	var pattern = dict["pattern"]
	var number = dict["number"]
	var type = dict["type"]
	var spacing_sec = dict["spacing_sec"]
	var heckler: Heckler = get_heckler(row, col)
	heckler.send_projectiles(pattern, number, type, spacing_sec)


