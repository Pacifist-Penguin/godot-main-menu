class_name OptionRow extends HBoxContainer


# FIXME: Figure out how to use standard class constructor

func init(action_name):
	var OptionLabel := $'Label'
	var buttons := [$'Button1', $'Button2']
	var option_variants := InputMap.action_get_events(action_name)
	OptionLabel.text = action_name
	for i in range(option_variants.size()):
		if i < buttons.size():
			buttons[i].text = option_variants[i].as_text()

