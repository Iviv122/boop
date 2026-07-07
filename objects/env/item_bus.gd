extends Resource
class_name ItemBus

signal registred_duplicate(item : Node2D)
signal level_reset()

func reset() -> void:
	level_reset.emit()

func register_duplicate(item : Node2D) -> void:
	registred_duplicate.emit(item.duplicate())
