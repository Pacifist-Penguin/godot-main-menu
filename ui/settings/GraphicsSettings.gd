extends VBoxContainer

@onready var FOV := $FOVSlider
@onready var FOVValueLabel := $FOVLabels/FOVValueLabel
@onready var SettingsContainers := [$AdvancedResolutionSettings, $SimpleResolutionSettings]
@onready var AspectRatio := $SimpleResolutionSettings/AspectRatio
@onready var ResolutionSimple := $SimpleResolutionSettings/ResolutionSimple

const SIMPLE_RESOLUTIONS := GlobalConfig.SIMPLE_RESOLUTIONS

func _ready():
	for aspect_ratio in SIMPLE_RESOLUTIONS.keys():
		AspectRatio.add_item(aspect_ratio)
	# TODO: Set resolution control after
	ProjectSettings.set_setting("display/window/size/viewport_width", 1440)

func _set_default_resolution():
	DisplayServer.screen_get_size()

func _get_current_aspect_ratio() -> String:
	var screen_size := DisplayServer.screen_get_size()
	for key in SIMPLE_RESOLUTIONS.keys():
		var current_array : Array[String] = SIMPLE_RESOLUTIONS[key]
		var stringified_screen_size := str(screen_size.x, "x", screen_size.y)
		if (current_array.find(stringified_screen_size) != -1):
			return key
	return "Other"

func _resolution_set():
	var active_item: String = AspectRatio.get_item_text(AspectRatio.get_selected_id())
	for resolution in SIMPLE_RESOLUTIONS[active_item]:
		ResolutionSimple.add_item(resolution)

func _resolution_setter(new_resolution: Vector2i):
	get_tree().get_root().set_size(new_resolution)

func _on_fov_slider_value_changed(value):
	FOVValueLabel.text = str(value)

func _on_advanced_settings_button_toggled(_button_pressed):
	for containers in SettingsContainers:
		containers.visible = not containers.visible

func _on_window_mode_item_selected(index):
	match (index):
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			_resolution_setter(Vector2i(1280, 720))
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

func _on_aspect_ratio_picker_item_selected(_index):
	_resolution_set()


func _on_v_sync_button_toggled(button_pressed):
	DisplayServer.window_set_vsync_mode(button_pressed)
