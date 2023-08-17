extends Node

# Initialization variables
var size : int				# Number of bodies
var spacing : float			# Average space between the orbits of bodies


# Instance variables
var player_position := Vector2.ZERO
var star : Star
var bodies : Array[Body]


# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.set_max_fps(120)
	generate()
	add_player()
	

func generate(sz: int = 6, sp : float = 500) -> void:
	var star_prototype = preload("res://game/star.tscn")
	var body_prototype = preload("res://game/body.tscn")
	
	size = sz
	spacing = sp
	
	# Generate star
	star = star_prototype.instantiate()
	star.type = Star.Class.CLASS_G
	add_child(star)
	
	
	# Place player spawn point
	var dist_from_star : float = 300
	player_position = Vector2(dist_from_star * 0.75, 0).rotated(randf_range(0, TAU))
	
	# Generate bodies
	for i in range(size):
		var body = body_prototype.instantiate()
		bodies.append(body)
		
		var scale : float = randf_range(0.1, 1)
		var orbit : float = randf_range(0.01, 0.1)
		
		body.orbital_radius = dist_from_star
		body.orbital_speed = orbit
		body.primary = star
		
		body.set_scale(Vector2(scale, scale))
		add_child(body)
		
		
		dist_from_star += randf_range(spacing - 100, spacing + 100)

	
func add_player():
	var player_prototype = preload("res://game/player.tscn")
	var player = player_prototype.instantiate()
	add_child(player)
	player.start(player_position)
	
	
	
	
	
