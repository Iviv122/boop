extends Control

@export var LoadLevelScript : Script
@export var MinButtonSize : Vector2 = Vector2(32,32)
@export var ButtonSFX : PackedScene
var num : int = 0
var levels_beated : int = 1

func get_num() -> int:
	num+=1
	return num

func load_levels() -> void:
	levels_beated = SaveInstance.load()

func _ready() -> void:
	load_levels()
	for i in get_children():
		i.queue_free()
	for i in SceneManager.levels:
		var b = Button.new()
		b.set_script(LoadLevelScript)


		b.custom_minimum_size = Vector2(32,32)

		var tnum = get_num()-1
		b.level_index = tnum
		b.disabled = levels_beated <= 0
		if levels_beated > 0:
			var sfx = ButtonSFX.instantiate()
			b.add_child(sfx)
		levels_beated-=1
		b.text = str(tnum+1)

		add_child(b)
