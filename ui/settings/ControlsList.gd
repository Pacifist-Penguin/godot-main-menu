extends VBoxContainer

const OptionRowNode := preload("OptionRow.tscn")

func _ready() -> void:
	var inputs := InputMap.get_actions()
	for action_name in inputs:
		var orn = OptionRowNode.instantiate()
		orn.init(action_name)
		self.add_child(orn)
