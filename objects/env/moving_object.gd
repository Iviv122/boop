extends Node2D
class_name MovingRoot

@export var points : Array[Vector2]
@export var speed : float = 0
@export var loop : bool = true

var t : Tween
var ind : int
var init_pos : Vector2

signal reached

func _ready() -> void:
	init_pos = global_position
	move_iter()
	reached.connect(move_iter)

func reset() -> void:
	global_position = init_pos
	ind = 0


func move_iter() -> void:
	move(points[ind])
	ind =  (ind + 1) % points.size()

func move(_point : Vector2) -> void:
	if t:
		t.kill()
	t = create_tween()

	t.tween_property(self,"global_position",_point,1/speed)
	await get_tree().create_timer(1/speed).timeout
	reached.emit()
