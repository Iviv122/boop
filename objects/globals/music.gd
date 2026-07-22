extends AudioStreamPlayer
class_name Music

@export var fade_duration : float = 1
@export var main_menu : AudioStream
@export var level : AudioStream

var music_volume = 0
var curr : AudioStream

func loop() -> void:
	await get_tree().create_timer(fade_duration).timeout
	stream_paused = false
	play()

func _ready() -> void:
	autoplay = true
	playing = true
	finished.connect(loop)
	load_music(main_menu)

func load_music(s : AudioStream):
	if s == curr:
		return
	fade_sound_out()
	await get_tree().create_timer(fade_duration).timeout
	stream = s
	play()
	fade_sound_in()

func fade_sound_out() ->void:
	var tween = get_tree().create_tween()
	tween.tween_property(self,"volume_db",-80,fade_duration)
	tween.play()

func fade_sound_in() ->void:
	var tween = get_tree().create_tween()
	tween.tween_property(self,"volume_db",music_volume,fade_duration)
	tween.play()
