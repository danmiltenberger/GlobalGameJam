extends Node2D
class_name HecklerHandler



# take a csv with defined paramters, pass to individual hecklers
# the individual hecklers are children

func get_heckler_from_col_row(col: int, row: int) -> Heckler:
	var heckler = get_node("")
	return heckler



