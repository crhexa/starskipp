class_name Body
extends Area2D

var t = 0

@export var primary: Area2D
@export var orbital_radius: float = 1000
@export var orbital_speed: float = 0.1

func _ready():
	pass
	
func _process(delta): 
	t = TimeController.time
	
	position = primary.position + Vector2(
		sin(t * orbital_speed) * orbital_radius,
		cos(t * orbital_speed) * orbital_radius
	)

	# Update shader
	$MainShader.material.set_shader_parameter("time", t)
	# update light origin

