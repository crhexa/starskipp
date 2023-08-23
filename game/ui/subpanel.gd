extends Panel

signal subpanel_focus_reset

@onready var screen_size = get_viewport_rect().size

func _on_top_bar_gui_input(event):
	subpanel_focus_reset.emit()
	z_index = 1
	
	if event is InputEventScreenDrag:
		position = (position + event.relative).clamp(Vector2.ZERO, screen_size - size)


func _on_exit_button_button_up():
	queue_free()

# Emits on a subpanel window gaining focus
func _on_subpanel_focus_reset():
	z_index = 0
