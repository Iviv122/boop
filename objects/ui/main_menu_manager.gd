extends Node2D
class_name MainMenuManager

@export var init_screen : int = 1
@export var off : float = 1920
var t : Tween

func _ready() -> void:
	change_instantly(init_screen)


func change_instantly(focus_id:int) -> void:
	var ind : int = 0
	var it = get_child(focus_id)

	for i in get_children():
		if ind != focus_id:
			i.offset.y = off
		ind += 1

	it.offset.y = 0

func change(focus_id:int) -> void:
	if t:
		t.kill()
	t = create_tween()

	var ind : int = 0
	var it = get_child(focus_id)

	for i in get_children():
		if ind != focus_id:
			t.tween_property(i,"offset:y",off,0.2)
		ind += 1

	t.tween_property(it,"offset:y",0,0.2)
