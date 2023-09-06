class_name PlanetTile extends Node

enum Flag {}

var modifiers : Array[ResourceModifier] = []
var flags : Array[Flag] = []

var building_primary : PlanetBuilding
var building_buffer : PlanetBuilding


func _ready():
	pass
	
	
func set_targets(planet_manager : ResourceManager):
	$ResourceManager.planet_target = planet_manager.planet.income_modifiers
	$ResourceManager.system_target = planet_manager.system.income_modifiers
	$ResourceManager.player_target = planet_manager.player.income_modifiers


func add_modifier(mod : ResourceModifier):
	modifiers.append(mod)
	$ResourceManager.get_group_income(mod.group).income_modifiers.append(mod)
	

func remove_modifier(mod : ResourceModifier):
	modifiers.erase(mod)
	$ResourceManager.get_group_income(mod.group).income_modifiers.erase(mod)
	

func process_resources():
	$ResourceManager.process_income()
