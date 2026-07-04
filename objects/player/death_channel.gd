extends Resource
class_name PlayerChannel

signal spawn(player : PlayerBody)
signal death(player : PlayerBody)

func created(player : PlayerBody) -> void:
	spawn.emit(player)

func die(player : PlayerBody) -> void:
	death.emit(player)
