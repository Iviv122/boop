extends Node2D
class_name MainMenuManager

@export var off : float = 1920
var curr_id : int = 1

var t : Tween

func _ready() -> void:
	change(0)
	await  get_tree().create_timer(3).timeout
	change(1)
	await  get_tree().create_timer(3).timeout
	change(2)

func change(focus_id:int) -> void:
	if t:
		t.kill()
	t = create_tween()

	for i in get_children():
		t.tween_property(i,"offset:y",i.offset.y+(curr_id - focus_id)*off,0.2)

	curr_id = focus_id
