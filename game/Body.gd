class_name Body
extends Node2D

@export var primary: Node2D
@export var orbital_radius: float = 1000
@export var orbital_speed: float = 0.1

func _ready():
	$MainShader.material.set_shader_parameter("seed", randf_range(1.0, 10.0))
	$SM_Selector.set_outline_radius($MainShader.size.x * 0.5 * scale.x)
	# issue no. 2
	
	
func _process(_delta): 
	var t = TimeController.time
	
	position = primary.position + Vector2(
		sin(t * orbital_speed) * orbital_radius,
		cos(t * orbital_speed) * orbital_radius
	) 

	# Update shader
	$MainShader.material.set_shader_parameter("time", t * 0.1)
	
	var primary_light = (-0.5 * position.normalized()) + Vector2(0.5, 0.5)
	$MainShader.material.set_shader_parameter("light_origin", primary_light)
