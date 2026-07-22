extends Node
class_name  SettingsManager

@export var vsync : CheckBox
@export var Sounds : Array[HSlider]

var sounds = [
	"master",
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
	var svsync = config.get_value("settings","vsync")
	set_vsync(svsync)
	vsync.set_pressed_no_signal(svsync)
	print(svsync)


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
