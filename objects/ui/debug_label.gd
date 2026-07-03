extends Label
class_name DebugLabel

@export var gameObject : Node
@export var valueName : StringName

func _process(_delta: float) -> void:
	text = str(gameObject.get(valueName))
