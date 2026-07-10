extends CanvasLayer

@export var gameState : GameState

func _ready() -> void:
	_hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if gameState.isPaused():
			_hide()
		else:
			_show()

func _hide() -> void:
	visible = false
	gameState.play_continue()

func _show() -> void:
	visible = true
	gameState.pause()
