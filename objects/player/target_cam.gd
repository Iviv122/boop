extends Camera2D
class_name TargetCam

@export var target : Node2D

@export var x : bool = true
@export var y : bool = true

func _process(_delta: float) -> void:
	if target:
		if x:
			global_position.x = target.global_position.x
		if y:
			global_position.y = target.global_position.y
