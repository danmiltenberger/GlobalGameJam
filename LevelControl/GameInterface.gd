extends CanvasLayer

@onready var health: Label = $Health


func _process(_delta: float) -> void:
	health.text = str(Globals.health)
