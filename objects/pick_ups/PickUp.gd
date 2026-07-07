extends Area2D
class_name PickUp

@export var pick_up_effect : PackedScene
@export var modulate_effect_self : bool = true
@export var itemBus : ItemBus

func destory_effect() -> void:
	var eff : GPUParticles2D = pick_up_effect.instantiate()
	get_tree().root.add_child(eff)
	eff.global_position = global_position
	if modulate_effect_self:
		eff.modulate = modulate
	eff.restart()
	var callback = func():
		eff.queue_free()
	get_tree().create_timer(eff.lifetime).timeout.connect(callback)

func effect(_player : PlayerBody) -> void:
	pass

func _ready() -> void:
	body_entered.connect(pick_up)

func pick_up(node : Node2D) -> void:
	if node is PlayerBody:

		register()
		effect(node)
		destory_effect()
		queue_free()

func register() -> void:
	itemBus.register_duplicate(self)
