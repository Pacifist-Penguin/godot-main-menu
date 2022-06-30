extends Node

const PATH = "user://settings.save"

const SIMPLE_RESOLUTIONS := {
	"16:9": ["3840x2160", 
		"2560x1440", 
		"2048x1152", 
		"1920x1080", 
		"1600x900", 
		"1536x864",
		"1366x768",
		"1360x768",
		"1280x720", 
		"640x360"
	],
	"16:10": ["2560x1600", 
		"1920x1200",
		"1680x1050",
		"1440x900",
		"1280x800"
	],
	"4:3": ["2048x1536",
		"1280x1024", 
		"1024x768", 
		"800x600"
	],
	"21:9": ["3440x1440", "2560x1080"]
}

@onready var DEFAULT_SETTINGS := {
	"resolution": DisplayServer.screen_get_size(),
	"aspect_ratio": "16:9",
	"anisotropic_filtration": ProjectSettings.get_setting("rendering/textures/default_filters/anisotropic_filtering_level"),
	"decals": ProjectSettings.get_setting("rendering/textures/decals/filter"),
	"light_projectors": ProjectSettings.get_setting("rendering/textures/light_projectors/filter"),
	"default_texture": ProjectSettings.get_setting("rendering/textures/canvas_textures/default_texture_filter"),
	
}

@onready var joy_is_connected : bool = not is_zero_approx(float (Input.get_connected_joypads().size()))

func _ready():
	Input.joy_connection_changed.connect(_on_joy_connection_changed)

func _on_joy_connection_changed(device, dsc):
	print(device, dsc)
	pass

var current_settings := {}

func _save_data():
	var file := File.new()
	file.open(PATH, File.WRITE)
	file.store_var(current_settings)
	file.close()
	_load_data()

func _load_data():
	var file := File.new()
	if not file.file_exists(PATH):
		_save_data()
	file.open(PATH, File.READ)
	current_settings = file.get_var()
	file.close()
	

func set_default():
	var directory := Directory.new()
	directory.remove(PATH)
	_load_data()
