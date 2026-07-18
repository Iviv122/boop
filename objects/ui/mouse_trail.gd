extends GPUParticles2D
class_name MouseTrail

@export var offset : Vector2 = Vector2.ZERO

func _process(_delta: float) -> void:
	global_position =  get_global_mouse_position()+offset
