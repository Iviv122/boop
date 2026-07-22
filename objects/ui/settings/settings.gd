extends Node
class_name  SettingsManager

@export var vsync : CheckBox
@export var sounds : Array[HSlider]

var _sounds = [
	"music",
	"sfx"
]

var config : ConfigFile = ConfigFile.new()


func _ready() -> void:
	vsync.toggled.connect(vsync_toggled)
	load_settings()

func save_settings() -> void:
	config.save("user://scores.cfg")

func load_settings() -> void:
	var err = config.load("user://scores.cfg")
	if err != OK:
		return
	var svsync = config.get_value("settings","vsync",true)
	set_vsync(svsync)
	vsync.set_pressed_no_signal(svsync)

	var sound = config.get_value("settings","music",-5)
	set_music(sound)
	sounds[0].value = sound


	sound = config.get_value("settings","sfx",-5)
	set_sfx(sound)
	sounds[1].value = sound


func set_vsync(mode : bool) -> void:
	if mode:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	print(mode)

func vsync_toggled(toggled_on: bool) -> void:
	config.set_value("settings","vsync",toggled_on)
	set_vsync(toggled_on)
	save_settings()



func set_sfx(value : float = -5) -> void:
	SFXINSTANCE.set_volume(value)


func set_music(value : float = -5) -> void:

	MusicInstance.music_volume = value
	MusicInstance.volume_db = value

func _on_music_value_changed(value: float) -> void:
	config.set_value("settings","music",value)
	set_music(value)
	save_settings()


func _on_sfx_value_changed(value: float) -> void:
	config.set_value("settings","sfx",value)
	set_sfx(value)
	save_settings()
