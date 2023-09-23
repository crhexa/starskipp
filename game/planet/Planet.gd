class_name Planet extends Node2D

@onready var system = get_parent()

@export var primary: Node2D
@export var orbital_radius : float = 1000
@export var orbital_speed : float = 0.1

var t_offset : float
var started : bool = false

# Determines appearance and how the rest of the planet's properties
enum Type { EMPTY, OCEAN_ROCKY, OCEAN_ICE, DRY_ROCKY, GAS_GIANT, ICE_GIANT }

# Planet habitability flags
enum Flag { SUNLIGHT_NONE, SUNLIGHT_DARK, SUNLIGHT_INTENSE,
			MAGNETIC_NONE, MAGNETIC_WEAK, MAGNETIC_STRONG,
			ATMOSPHERE_NONE, ATMOSPHERE_THIN, ATMOSPHERE_THICK,
			GRAVITY_NONE, GRAVITY_WEAK, GRAVITY_STRONG,
			RADIATION_HIGH, RADIATION_INTENSE
}

var properties = {
	"Type" : Type.EMPTY,
	"Mass" : -1,				# In terran masses (5.97 * 10^24 kg)
	
	"Flags" : []
}


func _ready():
	
	# Link resource manager
	$PlanetResources.income_ref = $ResourceManager.planet
	$ResourceManager.system_target = system.manager.system.income_modifiers
	$ResourceManager.player_target = system.manager.player.income_modifiers
	
	
	# Set rendering parameters
	t_offset = randf_range(0, 1000000)
	$MainShader.material.set_shader_parameter("seed", randf_range(1.0, 10.0))
	$SMSelector.set_outline_radius($MainShader.size.x * 0.5)
	# issue no. 2
	
	# set the initial position before the first frame
	orbit(t_offset)

	
func _process(_delta): 
	first_process()
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
	
	
func process_resources():
	$TileManager.process_resources()
	$ResourceManager.process_income() 
	$PlanetResources.process_storage($ResourceManager.planet)


func first_process():
	if started:
		return
	
	started = true
		
	# delete me
	$ResourceManager.system.income_modifiers.append(ResourceModifier.new(
		"Starting Income", SystemResources.Type["NOBLE_GASES"]["id"], ResourceModifier.Group.SYSTEM,
		ResourceModifier.Operation.OFFSET, 2.0, 5
	))
	
	$ResourceManager.system.income_modifiers.append(ResourceModifier.new(
		"Starting Income", SystemResources.Type["NOBLE_GASES"]["id"], ResourceModifier.Group.SYSTEM,
		ResourceModifier.Operation.ADDITIVE, 0.1, 5
	))
	
	$ResourceManager.system.income_modifiers.append(ResourceModifier.new(
		"Starting Income", SystemResources.Type["NOBLE_GASES"]["id"], ResourceModifier.Group.SYSTEM,
		ResourceModifier.Operation.OFFSET, 1, Utilities.INT_MAX
	))  
	
	$ResourceManager.system.income_modifiers.append(ResourceModifier.new(
		"Starting Income", SystemResources.Type["VOLATILES"]["id"], ResourceModifier.Group.SYSTEM,
		ResourceModifier.Operation.OFFSET, -1, 5
	))
