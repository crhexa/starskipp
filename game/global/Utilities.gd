class_name Utilities extends Node

const INT_MAX = 9223372036854775807

static func set_size_zero(arr : Array[float], size : int) -> void:
	arr.resize(size)
	arr.fill(0.0)

static func signal_termination(tree : SceneTree) -> void:
	tree.root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	tree.quit()
	
