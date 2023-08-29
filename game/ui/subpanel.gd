class_name Subpanel extends Panel

static var subpanels : Array[Subpanel]

@onready var screen_size = get_viewport_rect().size

var has_mouse_focus : bool = false

func _ready():
	Signals.subpanel_focus_reset.connect(_on_subpanel_focus_reset)
	bring_to_front()


func _exit_tree():
	subpanels.erase(self)


# GUI Input anywhere in the subpanel
func _on_gui_input(event):
	accept_event()
	if has_mouse_focus:
		return # ignore any further inputs after the first
	
	if event is InputEventMouseButton:
		bring_to_front()
		

# Gui Input only on the top bar
func _on_top_bar_gui_input(event):
	if event is InputEventScreenDrag:
		position = (position + event.relative).clamp(Vector2.ZERO, screen_size - size)
		accept_event()


func _on_exit_button_button_up():
	accept_event()
	queue_free()


# Reorder all existing subpanels based on array position
func _on_subpanel_focus_reset():
	z_index = subpanels.find(self)
	if z_index < subpanels.size() - 1:
		has_mouse_focus = false


# Send the current subpanel to the front of the drawing order (back of the array)
func bring_to_front():
	if not subpanels.has(self):
		subpanels.append(self)
		
	else:
		subpanels.erase(self)
		subpanels.push_back(self)
	
	has_mouse_focus = true
	Signals.subpanel_focus_reset.emit()
