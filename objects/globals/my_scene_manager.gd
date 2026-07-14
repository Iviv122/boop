extends Node
class_name MySceneManager

@export var main_menu : PackedScene
@export var playground : PackedScene
@export var levels : Array[PackedScene]


func load_playground(tree : SceneTree) -> void:
	if !tree:
		return
	tree.change_scene_to_packed.call_deferred(playground)

func load_main_menu(tree : SceneTree) -> void:
	if !tree:
		return
	tree.change_scene_to_packed.call_deferred(main_menu)

func load_level(tree : SceneTree,index : int) -> void:
	if !tree:
		return
	tree.change_scene_to_packed.call_deferred(levels[index])
