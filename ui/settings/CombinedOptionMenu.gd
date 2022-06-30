extends TabContainer

# This node is set in MainMenu.gd and should be set
# If i knew how to use classnames with script
# i'd implement it in class constructor	

var FallbackNode: VBoxContainer

func _ready():
	_focus_first_focusable_child(self)

func _focus_first_focusable_child(node: Control) -> bool:
	for child in node.get_children():
		if (child.get_focus_mode() == 2):
			child.grab_focus()
			return true
		else:
			if _focus_first_focusable_child(child):
				return true
	return false

func _scroll_tab(direction: int):
	var next_index : int = current_tab + direction
	if next_index > get_tab_count() - 1:
		next_index = 0
	elif next_index < 0:
		next_index = get_tab_count() - 1
	set_current_tab(next_index)
	
	_focus_first_focusable_child(get_current_tab_control())

func _unhandled_input(event):
	if (event.is_action_pressed("close")):
		get_tree().get_root().set_input_as_handled()
		self.queue_free()
	elif (event.is_action_pressed("previous_tab")):
		_scroll_tab(-1)
	elif (event.is_action_pressed("next_tab")):
		_scroll_tab(1)

func _exit_tree():
	FallbackNode.get_child(0).grab_focus()
