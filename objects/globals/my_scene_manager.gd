extends Node
class_name MySceneManager

@export var main_menu : PackedScene
@export var playground : PackedScene
@export var levels : Array[PackedScene]
@export var trans_time : float = 0.5

func _ready() -> void:
	FadeSreen.fade_out(trans_time)

func load_playground(tree : SceneTree) -> void:
	if !tree:
		return

	FadeSreen.fade_in(trans_time)
	await get_tree().create_timer(trans_time).timeout
	tree.change_scene_to_packed.call_deferred(playground)
	FadeSreen.fade_out(trans_time)

func load_main_menu(tree : SceneTree) -> void:
	if !tree:
		return

	FadeSreen.fade_in(trans_time)
	await get_tree().create_timer(trans_time).timeout
	tree.change_scene_to_packed.call_deferred(main_menu)
	FadeSreen.fade_out(trans_time)

func load_level(tree : SceneTree,index : int) -> void:
	if !tree:
		return

	FadeSreen.fade_in(trans_time)
	await get_tree().create_timer(trans_time).timeout
	tree.change_scene_to_packed.call_deferred(levels[index])
	FadeSreen.fade_out(trans_time)
