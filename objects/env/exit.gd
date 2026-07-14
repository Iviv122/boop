extends Area2D
class_name Exit

@export var next_ind : int = -1

func _load() -> void:
	if next_ind >= 0:
		SceneManager.load_level(get_tree(),next_ind-1)

func try_load(other : Node2D) -> void:
	if other is PlayerBody:
		_load()

func _ready() -> void:
	body_entered.connect(try_load)
