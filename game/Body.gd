class_name Body
extends Node2D

var t = 0

var primary: Body
var orbital_radius: float
var orbital_speed: float


func _process(delta): 
	t += delta
	
	position += Vector2(
		sin(t * orbital_speed) * orbital_radius,
		cos(t * orbital_speed) * orbital_radius
	)
