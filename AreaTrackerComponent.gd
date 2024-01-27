extends Node2D
class_name AreaTrackerComponent

@export var tracked_area : Area2D

# variables borrowed from this node
var tracked_bodies_list : Array
var tracked_bodies_dis_dict: Dictionary

var reference_point: Vector2

func _ready():
	# connect the given node to the functions I need
	tracked_area.body_entered.connect(body_entered)
	tracked_area.body_exited.connect(body_exited)
	
	# the distance in the dictionary is from a reference body
	#TODO - decide if i need to improve this?
	reference_point = global_position

func _process(_delta):
	reference_point = global_position
	tracked_bodies_dis_dict = distances_to_bodies(tracked_bodies_list,reference_point)

func body_entered(body):
	tracked_bodies_list = track_bodies_in_area(body, "+", tracked_bodies_list)

func body_exited(body):
	tracked_bodies_list = track_bodies_in_area(body, "-", tracked_bodies_list)



func track_bodies_in_area(body: Node2D, logic: String, list: Array) -> Array:
	# add the body to the list
	if logic == "+":
		list.append(body)

	# or remove the body from the list
	elif logic == "-":
		var index: int = list.find(body)
		list.remove_at(index)
	else:
		print("unexpected 'logic' string in area tracker: ", logic)
	
	# and hand back the list
#	print("the list is: ", list)
	return list

func distances_to_bodies(area_list: Array, point: Vector2) -> Dictionary:
	# given a list of bodies and a point inside an area, 
	# return a dict of form (key = relative distance, value = body) 
	var distance_dict: Dictionary = {}
	for body in area_list:
		var body_dis: Vector2 = body.global_position
		var dis_to = int(body_dis.distance_to(point))
		var key = dis_to
		var value = body
		distance_dict[key] = value
	return distance_dict




