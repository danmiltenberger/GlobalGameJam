class_name LabelResizer extends Node

@onready var label: Label = get_parent().get_node("Label")
@onready var collision: CollisionShape2D = get_parent().get_node("CollisionShape2D")

func set_text(text: String):
    label.text = "  " + text.trim_prefix(" ").trim_suffix(" ") + "  "

func _process(_delta):
    collision.shape.extents = Vector2(label.size.x, label.size.y)
    collision.position = Vector2(label.position.x, 0)
