extends Node2D

@export var player : PackedScene
@export var cam_smooth : float = 10

var curr_player : PlayerBody
var curr_camera : TargetCam

func _ready() -> void:
	spawn()
	create_cam()


func create_cam() -> void:
	if curr_camera:
		return;
	curr_camera = TargetCam.new()
	curr_camera.position_smoothing_enabled = true
	curr_camera.position_smoothing_speed = 10

	if !player:
		spawn()
	curr_camera.target = curr_player

	get_tree().root.add_child.call_deferred(curr_camera)

# argument becaise deathchannel argument
func spawn() -> void:

	curr_player = player.instantiate()
	curr_player.global_position = global_position
	get_tree().root.add_child.call_deferred(curr_player)

	if curr_camera:
		curr_camera.target = curr_player

	curr_player.died.connect(spawn)
