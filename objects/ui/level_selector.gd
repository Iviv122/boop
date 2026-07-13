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

		num = get_num()-1
		b.level_index = num

		b.text = str(num+1)
		b.pressed.connect(func(): print(b.text))

		add_child(b)
