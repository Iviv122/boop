extends Node
class_name MySceneManager

@export var main_menu : PackedScene
@export var levels : Array[PackedScene]

func load_main_menu(tree : SceneTree) -> void:
	if !tree:
		return
	tree.change_scene_to_packed(main_menu)

func load_level(tree : SceneTree,index : int) -> void:
	if !tree:
		return
	tree.change_scene_to_packed(levels[index])
