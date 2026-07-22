extends Button


@export var main_menu : bool
@export var playground: bool
@export var level_index : int = -1

func _pressed() -> void:

	if main_menu:
		MusicInstance.load_music(MusicInstance.main_menu)
		SceneManager.load_main_menu(get_tree())
	if playground:
		MusicInstance.load_music(MusicInstance.level)
		SceneManager.load_playground(get_tree())
	elif level_index >= 0:
		MusicInstance.load_music(MusicInstance.level)
		SceneManager.load_level(get_tree(),level_index)
