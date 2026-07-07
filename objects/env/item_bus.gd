extends Resource
class_name ItemBus

signal registred(item : Node2D)

func register(item : Node2D) -> void:
	registred.emit(item.duplicate())
