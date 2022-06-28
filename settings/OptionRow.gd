class_name OptionRow extends HBoxContainer
# кастомная функция
func init(actionName):
	var OptionLabel := $'Label'
	var buttons := [$'Button1', $'Button2']
	var optionVariants := InputMap.action_get_events(actionName)
	OptionLabel.text = actionName
	for i in range(optionVariants.size()):
		if i < buttons.size():
			buttons[i].text = optionVariants[i].as_text()	
