extends Camera2D
class_name TargetCam

@export var target : Node2D

func _process(_delta: float) -> void:
	if target:
		global_position = target.global_position
