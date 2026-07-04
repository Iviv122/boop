extends Area2D
class_name KillArea

func _ready() -> void:
	body_entered.connect(kill)

func kill(node : Node2D) -> void:
	if node is PlayerBody:
		node.die()
