extends PickUp
class_name ExtraJump

func effect(player : PlayerBody) -> void:
	player.grant_extra_double_jump()
