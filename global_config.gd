extends Node

const PATH = "user://settings.cfg"

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
	"Resolution": DisplayServer.screen_get_size(),
	"Aspect_ratio": "16:9",
	"Anisotropic_filtration": ProjectSettings.get_setting("rendering/textures/default_filters/anisotropic_filtering_level"),
	"Decals": ProjectSettings.get_setting("rendering/textures/decals/filter"),
	"Light_projectors": ProjectSettings.get_setting("rendering/textures/light_projectors/filter"),
	"Default_texture": ProjectSettings.get_setting("rendering/textures/canvas_textures/default_texture_filter"),
	"Thread_model": ProjectSettings.get_setting("rendering/driver/threads/thread_model"),
	"Half_GI": ProjectSettings.get_setting("rendering/global_illumination/gi/use_half_resolution"),
	"DOF_Bokeh_Shape": ProjectSettings.get_setting("rendering/camera/depth_of_field/depth_of_field_bokeh_shape"),
	"DOF_Quality": ProjectSettings.get_setting("rendering/camera/depth_of_field/depth_of_field_bokeh_quality"),
	"ODF_Jitter": ProjectSettings.get_setting("rendering/camera/depth_of_field/depth_of_field_use_jitter"),
	"SSAO_Quaity": ProjectSettings.get_setting("rendering/environment/ssao/quality"),
	"SSIL_Quality": ProjectSettings.get_setting("rendering/environment/ssil/quality"),
	"Glow_upscale_mode": ProjectSettings.get_setting("rendering/environment/glow/upscale_mode"),
	"Glow_high_quality": ProjectSettings.get_setting("rendering/environment/glow/use_high_quality"),
	"Screen_space_reflection_roughness_quaity": ProjectSettings.get_setting("rendering/environment/screen_space_reflection/roughness_quality"),
	"Subsurface_scattering_quality": ProjectSettings.get_setting("rendering/environment/subsurface_scattering/subsurface_scattering_quality"),
	"Volumetric_fog_volume_size": ProjectSettings.get_setting("rendering/environment/volumetric_fog/volume_size"),
	"Volumetric_fog_volume_depth": ProjectSettings.get_setting("rendering/environment/volumetric_fog/volume_depth"),
	"Volumetric_fog_use_filter": ProjectSettings.get_setting("rendering/environment/volumetric_fog/use_filter"),
	"Use_TAA": ProjectSettings.get_setting("rendering/anti_aliasing/quality/use_taa"),
	"Screen_space_AA": ProjectSettings.get_setting("rendering/anti_aliasing/quality/screen_space_aa"),
	"MSAA": ProjectSettings.get_setting("rendering/anti_aliasing/quality/msaa"),
	"Use_Debanding": ProjectSettings.get_setting("rendering/anti_aliasing/quality/use_debanding"),
	"Use_Occlusiton_Culling": ProjectSettings.get_setting("rendering/occlusion_culling/use_occlusion_culling"),
	"Occlusion_Culling_quality": ProjectSettings.get_setting("rendering/occlusion_culling/bvh_build_quality"),
	"Mesh_LOD": ProjectSettings.get_setting("rendering/mesh_lod/lod_change/threshold_pixels")
}

@onready var joy_is_connected : bool = not is_zero_approx(float (Input.get_connected_joypads().size()))


func _ready():
	print(DEFAULT_SETTINGS)
	Input.joy_connection_changed.connect(_on_joy_connection_changed)

func _on_joy_connection_changed(device, dsc):
	print(device, dsc)
	pass

var current_settings := {}

func _save_data():
	var file := ConfigFile.new()
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
