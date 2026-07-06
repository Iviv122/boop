extends ColorRect
class_name FadeScreen

@export var player_channel : PlayerBus

var tween : Tween

func _ready() -> void:
	player_channel.spawn.connect(fade_out)
	player_channel.death.connect(fade_in)

func fade_in(_player : PlayerBody) -> void:

	print(_player)
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self,"self_modulate:a",1,0.1)

func fade_out(_player : PlayerBody) -> void:

	print(_player)
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self,"self_modulate:a",0,0.1)
