extends Node2D

@onready var area_tracker: AreaTrackerComponent = $AreaTrackerComponent
@onready var inspect_component: InspectComponent = $InspectComponent

func _ready() -> void:
	if Globals.dev_mode == true:
		$".".visible = true
	else:
		$".".visible = false

func _process(_delta: float) -> void:
	position = get_global_mouse_position()
	inspect_component.display(area_tracker.tracked_bodies_list)
