extends Area2D
class_name SpawnPoint

@export var player : PackedScene
@export var cam_smooth : float = 10

@export var first : bool = false
@export var spawnPointChannel : SpawnPointChannel
@export var toRemove : Array[Node2D]
@export var spawn_camera : bool = true
@export var spawn_effect : PackedScene

var id : int

func getPlayer() -> PlayerBody:
	return spawnPointChannel.curr_player

func getCamera() -> TargetCam:
		return spawnPointChannel.curr_camera

func setCamera(cam : TargetCam):
	spawnPointChannel.curr_camera = cam
func setPlayer(_player : PlayerBody):
	spawnPointChannel.curr_player =_player


func _ready() -> void:
	spawnPointChannel.respawn.connect(try_spawn)
	if first:
		activate()
		spawn()
		create_cam()
	else:
		body_entered.connect(try_activate)


func svfx() -> void:
	var eff = spawn_effect.instantiate() as GPUParticles2D
	eff.restart()
	eff.global_position = global_position
	get_tree().current_scene.add_child.call_deferred(eff)

func activate():

	spawnPointChannel.subscribe()
	id = spawnPointChannel.get_id()
	spawnPointChannel.activated(id)
	for i in toRemove:
		i.queue_free()

func try_activate(node : Node2D) -> void:
	if node is PlayerBody:
		activate()

func try_spawn(other_id: int) -> void:
	if other_id == id:
		spawn()

func create_cam() -> void:
	if !spawn_camera:
		return
	if getCamera():
		return;
	setCamera(TargetCam.new())
	getCamera().position_smoothing_enabled = true
	getCamera().position_smoothing_speed = 10

	if !player:
		spawn()
	getCamera().target = getPlayer()

	get_tree().current_scene.add_child.call_deferred(getCamera())

# argument becaise deathchannel argument
func spawn() -> void:
	if getPlayer():
		getPlayer().queue_free()

	svfx()

	setPlayer(player.instantiate())
	getPlayer().global_position = global_position
	get_tree().current_scene.add_child.call_deferred(getPlayer())

	if getCamera() && spawn_camera:
		getCamera().target = getPlayer()
