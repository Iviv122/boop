extends Resource
class_name SpawnPointChannel

@export var deathChannel : PlayerBus

var curr_player : PlayerBody
var curr_camera : TargetCam

# means another point is activated, i need to deactivate
signal respawn(id : int)

var curr_id : int = -1
var id : int = 0

func activated(_id : int):
	curr_id = _id

func spawn(_node : PlayerBody) -> void:
	respawn.emit(id)

func subscribe() -> void:
	if !deathChannel.death.is_connected(spawn):
		deathChannel.death.connect(spawn)

func get_id() -> int:
	id+=1
	return id
