extends Node2D

# Initialization variables
var size : int				# Number of bodies
var spacing : float			# Average space between the orbits of bodies


# Instance variables
var player_position := Vector2.ZERO
var star : Node2D
var bodies : Array[Node2D]


@onready var player_prototype = preload("res://game/player.tscn")
@onready var star_prototype = preload("res://game/star.tscn")
@onready var body_prototype = preload("res://game/body.tscn")


@export var orbit_color : Color
@export var orbit_width : int = 3


func _ready():
	Engine.set_max_fps(120)
	generate()
	# add_player()
	TimeController.swap_timescale()
	
		
func _process(_delta):
	
	if Input.is_action_just_pressed("toggle_pause"):
		TimeController.swap_timescale()		
	
	elif Input.is_action_just_pressed("time_speed_up"):
		TimeController.set_timescale(10.0)
		
	elif Input.is_action_just_pressed("time_slow_down"):
		TimeController.set_timescale(1.0)
	
	
func _draw():
	# Draw orbit lines for each body
	for body in bodies:
		draw_arc(star.position, body.orbital_radius, 0, TAU, 256, orbit_color, orbit_width, false)
		

func generate(sz: int = 6, sp : float = 700) -> void:
	size = sz
	spacing = sp
	
	# Generate star
	star = star_prototype.instantiate()
	star.properties["Type"] = Star.SpectralClass.CLASS_G
	add_child(star)
	
	
	# Place player spawn point
	var dist_from_star : float = 1000
	player_position = Vector2(dist_from_star * 0.75, 0).rotated(randf_range(0, TAU))
	
	# Generate bodies
	for i in range(size):
		var body = body_prototype.instantiate()
		bodies.append(body)
		
		var s : float = randf_range(0.75, 1.5)
		var o : float = randf_range(0.01, 0.1)
		
		body.orbital_radius = dist_from_star
		body.orbital_speed = o
		body.primary = star
		
		body.set_scale(Vector2(s, s))
		add_child(body)
		
		
		dist_from_star += randf_range(spacing - 100, spacing + 100)
	
	
func add_player():
	var player = player_prototype.instantiate()
	add_child(player)
	player.start(player_position)
