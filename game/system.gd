class_name System extends Node2D

@onready var player_prototype = preload("res://game/player.tscn")
@onready var star_prototype = preload("res://game/star/star.tscn")
@onready var planet_prototype = preload("res://game/planet/planet.tscn")

@onready var manager : ResourceManager = $ResourceManager

@export var orbit_color : Color
@export var orbit_width : int = 3



# Initialization variables
var size : int				# Number of bodies
var spacing : float			# Average space between the orbits of bodies


# Instance variables
var player_position := Vector2.ZERO
var star : Node2D
var planets : Array[Node2D]



func _ready():
	Engine.set_max_fps(120)
	generate()

	TimeController.swap_timescale()
	Signals.month_passed.connect(_on_month_passed)
	
	# Link resource manager
	$SystemResources.income_ref = $ResourceManager.system
	# $ResourceManager.player_target = player.manager.player.income_modifiers
	
	init_ui()
	
		
func _process(_delta):
	
	if Input.is_action_just_pressed("toggle_pause"):
		TimeController.swap_timescale()		
	
	elif Input.is_action_just_pressed("time_speed_up"):
		TimeController.set_timescale(100.0)
		
	elif Input.is_action_just_pressed("time_slow_down"):
		TimeController.set_timescale(1.0)
	
	
func _draw():
	# Draw orbit lines for each planet
	for planet in planets:
		draw_arc(star.position, planet.orbital_radius, 0, TAU, 256, orbit_color, orbit_width, false)
		
		
func _on_month_passed():
	for planet in planets:
		planet.process_resources()
	
	$ResourceManager.process_income()
	$SystemResources.process_storage($ResourceManager.system)
	

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
		var planet = planet_prototype.instantiate()
		planets.append(planet)
		
		var s : float = randf_range(0.75, 1.5)
		var o : float = randf_range(0.01, 0.1)
		
		planet.orbital_radius = dist_from_star
		planet.orbital_speed = o
		planet.primary = star
		
		planet.set_scale(Vector2(s, s))
		add_child(planet) 
		
		
		dist_from_star += randf_range(spacing - 100, spacing + 100)
	
	
func add_player():
	var player = player_prototype.instantiate()
	add_child(player)
	player.start(player_position)


func init_ui():
	$CanvasLayer/Interface/ResourceDisplayBar.set_resource($SystemResources)
	Signals.resource_update.emit($SystemResources)
