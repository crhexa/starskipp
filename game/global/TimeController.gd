extends Node


var time = 0
var timescale = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta * timescale


func pause():
	timescale = 0
