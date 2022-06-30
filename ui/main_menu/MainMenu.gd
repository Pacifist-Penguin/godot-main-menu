extends VBoxContainer

const CombinedOptionMenu := preload("../settings/CombinedOptionMenu.tscn")

func _ready():
	$ResumeButton.grab_focus()

func _on_quit_button_pressed():
	get_tree().quit()

func _on_resume_button_pressed():
	self.visible = false
	get_tree().paused = false
	self.queue_free()

func _on_settings_button_pressed():
	var SettingsInstance := CombinedOptionMenu.instantiate()
	SettingsInstance.FallbackNode = self
	get_tree().get_root().add_child(SettingsInstance)

func _unhandled_input(event):
	if event.is_action_pressed("close"):
		_on_resume_button_pressed()
