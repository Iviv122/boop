extends Node
class_name ButtonVFX

@export var hover_sound : AudioStream
@export var click_sound : AudioStream

func _ready() -> void:
	var parent = get_parent()
	if parent is Button:
		if hover_sound && parent:
			parent.mouse_entered.connect(
				func():
					SFXINSTANCE.play(hover_sound)
			)
		if click_sound && parent:
			parent.pressed.connect(
				func():
					SFXINSTANCE.play(click_sound)
			)
	if parent is Control:
		parent.mouse_entered.connect(
			func():
				SFXINSTANCE.play(hover_sound)
		)
