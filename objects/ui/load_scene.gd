extends Button


@export var main_menu : bool
@export var level_index : int = -1

func _pressed() -> void:

	if main_menu:
		SceneManager.load_main_menu(get_tree())
	elif level_index >= 0:
		SceneManager.load_level(get_tree(),level_index)
