extends Button

@export var manager : MainMenuManager
@export var id : int

func _pressed() -> void:
	manager.change(id)
