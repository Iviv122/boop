extends Resource
class_name GameState

var state : State = State.Play

signal changed_state

func play_continue() -> void:
	state = State.Play
	changed_state.emit()
func pause() -> void:
	state = State.Pause
	changed_state.emit()



enum State{
	Pause,
	Play
}
