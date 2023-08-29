class_name Body
extends Node2D

@export var primary: Node2D
@export var orbital_radius : float = 1000
@export var orbital_speed : float = 0.1

var t_offset


func _ready():
	t_offset = randf_range(0, 1000000)
	$MainShader.material.set_shader_parameter("seed", randf_range(1.0, 10.0))
	$SMSelector.set_outline_radius($MainShader.size.x * 0.5 * scale.x)
	# issue no. 2
	
	# set the initial position before the first frame
	orbit(t_offset)

	
func _process(_delta): 
	orbit(t_offset + TimeController.time)
	
	
# Update the body's position and shader based on time
func orbit(time : float = 0):
	
	position = primary.position + Vector2(
		sin(time * orbital_speed) * orbital_radius,
		cos(time * orbital_speed) * orbital_radius
	) 

	# Update shader
	$MainShader.material.set_shader_parameter("time", time * 0.1)
	
	var primary_light = (-0.5 * position.normalized()) + Vector2(0.5, 0.5)
	$MainShader.material.set_shader_parameter("light_origin", primary_light)
	
	
