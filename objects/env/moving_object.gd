extends Node2D
class_name MovingRoot

@export var points : Array[Vector2]
@export var speed : float = 0
@export var loop : bool = true
@export var reset_bus : ItemBus
@export var gameState : GameState

var ind : int = 0
var init_pos : Vector2
signal reached

func _ready() -> void:
	init_pos = global_position
	move_iter()
	reached.connect(move_iter)
	reset_bus.level_reset.connect(reset)

func reset() -> void:
	print("reset")
	global_position = init_pos
	ind = 0

func move_iter() -> void:
	ind = (ind + 1) % points.size()

func _process(delta: float) -> void:

	if gameState.isPaused():
		return

	if global_position.is_equal_approx(points[ind]):
		reached.emit()

	global_position = global_position.move_toward(points[ind],speed*delta)
