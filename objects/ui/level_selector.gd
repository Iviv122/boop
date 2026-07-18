extends Control

@export var LoadLevelScript : Script
@export var MinButtonSize : Vector2 = Vector2(32,32)
var num = 0

func get_num() -> int:
	num+=1
	return num


func _ready() -> void:
	for i in get_children():
		i.queue_free()
	for i in SceneManager.levels:
		var b = Button.new()
		b.set_script(LoadLevelScript)

		b.custom_minimum_size = Vector2(32,32)

		var tnum = get_num()-1
		b.level_index = tnum
		b.text = str(tnum+1)

		add_child(b)
