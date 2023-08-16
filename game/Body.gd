class_name Body
extends Area2D

var t = 0

@export var primary: Area2D
@export var orbital_radius: float = 1000
@export var orbital_speed: float = 0.1

func _process(delta): 
	t += delta
	
	position = primary.position + Vector2(
		sin(t * orbital_speed) * orbital_radius,
		cos(t * orbital_speed) * orbital_radius
	)

	
	
	
