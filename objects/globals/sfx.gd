class_name SFX
extends Node

@export var urgent_players = 4
@export var num_players = 8
@export var max_sound_in_queue = 20

var available = []
var queue = []

var urgent_available = []
var urgent_queue = []

func _ready():
		for i in urgent_players:
			var p = AudioStreamPlayer.new()
			add_child(p)
			urgent_available.append(p)
			p.finished.connect( func() : _on_urgent_stream_finished(p))

		for i in num_players:
			var p = AudioStreamPlayer.new()
			add_child(p)
			available.append(p)
			p.finished.connect( func() : _on_stream_finished(p))


func set_volume(val : float) -> void:
	for i in get_children():
		if i is AudioStreamPlayer:
			i.volume_db = val

func _on_urgent_stream_finished(stream):
		urgent_available.append(stream)
func urgent_play(sound_path):
		urgent_queue.append(sound_path)


func _on_stream_finished(stream):
		available.append(stream)
func play(sound_path):
		if queue.size() <= max_sound_in_queue:
			queue.append(sound_path)


func _process(_delta):
		if not urgent_queue.is_empty() and not urgent_available.is_empty():
			urgent_available[0].stream = urgent_queue.pop_front()
			urgent_available[0].play()
			urgent_available.pop_front()

		if not queue.is_empty() and not available.is_empty():
			available[0].stream = queue.pop_front()
			available[0].play()
			available.pop_front()
