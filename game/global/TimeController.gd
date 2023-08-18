extends Node


var time = 0
var timescale : float = 1
var delta_t

func _ready():
	process_priority = -1

func _process(delta):
	delta_t = delta * timescale
	time += delta_t


# Instance methods
func set_timescale(scale : float):
	timescale = scale
