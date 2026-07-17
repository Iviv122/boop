extends Control
class_name UIOffset

@export var target_offset : Vector2
@export var time : float

@export var change_parent : Control
@export var listen_parent : Control
var t : Tween

func a1() -> void:
	print("in")
	if t:
		t.kill()
	t = create_tween()
	t.tween_property(change_parent,"offset_transform_position",target_offset,time).set_trans(Tween.TRANS_QUAD)

func a2() -> void:

	print("out")
	if t:
		t.kill()
	t = create_tween()
	t.tween_property(change_parent,"offset_transform_position",Vector2.ZERO,time).set_trans(Tween.TRANS_QUAD)

func _ready() -> void:
	await get_tree().process_frame

	change_parent.offset_transform_enabled = true

	listen_parent.mouse_entered.connect(a1)
	listen_parent.mouse_exited.connect(a2)
