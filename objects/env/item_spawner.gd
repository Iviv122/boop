extends Node
class_name ItemSpawner

@export var itemBus : ItemBus
@export var playerBus : PlayerBus

var items : Dictionary

func respawn(_player: PlayerBody) -> void:
	for i in items:
		get_tree().current_scene.add_child(i.duplicate())
	for i in items:
		items.erase(i)

func register(node : Node2D) -> void:
	print(node)
	if items.has(node):
		return;
	items.set(
		node,
		node.global_position
	)

func _ready() -> void:
	itemBus.registred.connect(register)
	playerBus.death.connect(respawn)
