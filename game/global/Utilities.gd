class_name Utilities

const INT_MAX = 9223372036854775807

static func set_size_zero(arr : Array[float], size : int) -> void:
	arr.resize(size)
	arr.fill(0.0)
