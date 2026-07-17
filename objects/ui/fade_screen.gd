extends CanvasLayer
class_name FadeScreen

@export var colorRect : ColorRect

var tween : Tween


func fade_in(duration : float) -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(colorRect,"self_modulate:a",1,duration)

func fade_out(duration : float) -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(colorRect,"self_modulate:a",0,duration)
