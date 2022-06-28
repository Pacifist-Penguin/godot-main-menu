extends TabContainer

# This node is set in MainMenu.gd and should be set
# If i knew how to use classnames with script
# i'd implement it in class constructor	

var FallbackNode: VBoxContainer

func _find_node_to_focus(node: Control):
	for child in node.get_children():
		if (child.get_focus_mode() == 2):
			print(child)
			child.grab_focus()
			break
			return
		else:
			_find_node_to_focus(child)

func _scroll_tab(direction: int):
	var next_index : int = current_tab + direction
	if next_index > get_tab_count() - 1:
		next_index = 0
	elif next_index < 0:
		next_index = get_tab_count() - 1
	set_current_tab(next_index)
	
	
	
	# FIXME: Shouldn't imply that there's certain depth. Too bad!
	# Feature creep without fixing this should be considered harmful
	_find_node_to_focus(get_current_tab_control())
	# _recursive_search(next_node_to_focus)

func _unhandled_input(event):
	if (event.is_action_released("close")):
		get_tree().get_root().set_input_as_handled()
		self.queue_free()
	elif (event.is_action_released("previous_tab")):
		_scroll_tab(-1)
	elif (event.is_action_released("next_tab")):
		_scroll_tab(1)

func _exit_tree():
	FallbackNode.get_child(0).grab_focus()
