extends Camera2D

@export var speed : float = 400

var levels = [2.0, 1.5, 1, 0.75, 0.55, 0.40, 0.35]
var zoom_level : int = 2

func _process(delta):
	var x_dir : float = 0
	var y_dir : float = 0
	
	# Camera Movement
	if Input.is_action_pressed("camera_left"):
		x_dir -= 1
	
	if Input.is_action_pressed("camera_right"):
		x_dir += 1
		
	if Input.is_action_pressed("camera_up"):
		y_dir -= 1
		
	if Input.is_action_pressed("camera_down"):
		y_dir += 1
		
	offset += (speed + (zoom_level * 200)) * delta * Vector2(x_dir, y_dir).normalized()


	# Camera Zoom
	if Input.is_action_just_pressed("zoom_out"):
		step_zoom(1)
	
	elif Input.is_action_just_pressed("zoom_in"):
		step_zoom(-1)
		
		
func step_zoom(steps : int):
	zoom_level = clamp(zoom_level + steps, 0, levels.size() - 1)
	zoom = Vector2.ONE * levels[zoom_level]
	
	
