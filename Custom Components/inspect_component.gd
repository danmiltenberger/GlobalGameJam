extends VBoxContainer
class_name InspectComponent

@export var auto_get_values : bool = true
@export var main_component : Node2D
@export var health_component : HurtboxHealthComponent
@export var just_health: bool = false

@export var font_size: int = 30
@export var outline_size: int = 10

#region Regular Values
var status: String
var health: int
var atk_cooldown: int
var can_attack: bool

var dev_dict: Dictionary
var label_settings: LabelSettings
#TODO - add an automatic way of showing these values instead of writing the dict
#
func _ready():
	label_settings = LabelSettings.new()
	

#func get_values() -> Dictionary:
	#var nodes = main_component.get_children()
	#for node in nodes:
		#if node is HurtboxHealthComponent:
			#health = node.current_health
		#elif node is AttackLogicComponent:
			#can_attack = node.can_attack
			#atk_cooldown = node.cooldown_sec
		#else:
			#continue
	#var dict = {
		#"Health" : health,
		#"Can Attack": can_attack,
		#"Atk Cooldown": atk_cooldown,
	#}
	#return dict

func _process(_delta):
	if Globals.dev_mode == true:
		visible = true
	else:
		visible = false
		
	if health_component != null and just_health:
		var dict = {
			"Health": health_component.current_health
		}
		show_dict(dict)

func display(item):
	if item is Array:
		show_list(item)
	elif item is Dictionary:
		show_dict(item)
	else:
		print("inspect component: display(item): unexpected error in item: ", item)

func set_label_settings() -> LabelSettings:
	label_settings.font_size = font_size
	label_settings.outline_color = Color.BLACK
	label_settings.outline_size = outline_size
	return label_settings

func show_list(list : Array):
	# given a list, print each item on a new line (new label)
	
	label_settings = set_label_settings()
	# add a label for each item in list, remove a label if that item is off the list
	var labels = self.get_children()

	# if empty, create one that just says empty
	if list.is_empty():		
		# clear all the labels
		for label in labels:
			label.queue_free()
		var label : Label = Label.new()
		label.text = "Empty"
		
	# if there are items in the list:
	else:
	# start by getting rid of all of them (TODO - fix this, not very efficient)
		for label in labels:
			label.queue_free()
	# create new labels
		for item in list:
			var label : Label = Label.new()
			self.add_child(label)
			label.text = str(item)
			label.label_settings = label_settings

func show_dict(dict: Dictionary):
	# given a dictionary, print the keys and values (a labeled list?)
	label_settings = set_label_settings()
	
	# add a label for each item in list, remove a label if that item is off the list
	var labels = self.get_children()

	var keys: Array = dict.keys()
	# if empty, create one that just says empty
	if keys.is_empty():		
		# clear all the labels
		for label in labels:
			label.queue_free()
		var label : Label = Label.new()
		label.text = "Empty"
	
	else:
	# start by getting rid of all of them (TODO - fix this, not very efficient)
		for label in labels:
			label.queue_free()
	# create new labels
		for key in keys:
			var label : Label = Label.new()
			self.add_child(label)
			label.text = str(key) + "  :  " + str(dict[key])
			label.label_settings = label_settings
