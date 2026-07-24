extends Node
class_name Save

var level_beat : int = 0
var config : ConfigFile = ConfigFile.new()

signal reseted

func load() -> int:
	var err = config.load("user://level.cfg")
	if err != OK:
		return 1

	level_beat = config.get_value("save","level",1)
	return level_beat

func save(value : int) -> void:
	config.set_value("save","level",value)
	config.save("user://level.cfg")

func reset() -> void:
	config.set_value("save","level",1)
	config.save("user://level.cfg")
	reseted.emit()
