extends Control

var num = 0

func get_num() -> int:
	num+=1
	return num


func _ready() -> void:
	for i in SceneManager.levels:
		var b = Button.new()

		b.text = str(get_num())
		b.pressed.connect(func(): print(b.text))

		add_child(b)
