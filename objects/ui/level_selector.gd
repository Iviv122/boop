extends Control

@export var LoadLevelScript : Script
var num = 0

func get_num() -> int:
	num+=1
	return num


func _ready() -> void:
	for i in SceneManager.levels:
		var b = Button.new()
		b.set_script(LoadLevelScript)

		var tnum = get_num()-1
		b.level_index = tnum
		b.text = str(tnum+1)

		add_child(b)
