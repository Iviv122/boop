extends Area2D
class_name Exit

@export var next_ind : int = -1
@export var exit_effect : PackedScene
@export var exit_sound : AudioStream

func svfx(player : PlayerBody) -> void:

	SFXINSTANCE.urgent_play(exit_sound)

	var eff = exit_effect.instantiate() as GPUParticles2D

	eff.restart()
	eff.global_position = global_position

	player.active = false
	var t = create_tween()
	t.set_parallel(true)
	t.tween_property(player,"global_scale",Vector2.ZERO,0.3)
	t.tween_property(player,"global_position",global_position,0.3)
	t.tween_property(player,"rotation_degrees",360,0.3)


	get_tree().current_scene.add_child(eff)

func _load() -> void:
	if next_ind >= 0:
		await get_tree().create_timer(0.4).timeout
		SceneManager.load_level(get_tree(),next_ind-1)

func try_load(other : Node2D) -> void:
	if other is PlayerBody:
		svfx(other)
		_load()

func _ready() -> void:
	body_entered.connect(try_load)
