extends Panel

@onready var screen_size = get_viewport_rect().size

func _on_top_bar_gui_input(event):
	if event is InputEventScreenDrag:
		position = (position + event.relative).clamp(Vector2.ZERO, screen_size)
		# fix bounds for submenu box
