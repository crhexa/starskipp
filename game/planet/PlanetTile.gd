class_name PlanetTile extends Node

enum Flags {}

@onready var manager : ResourceManager = $ResourceManager

var modifiers : Array[ResourceModifier] = []
var flags : Array[Flags] = []

var building_primary : PlanetBuilding
var building_buffer : PlanetBuilding


func _ready():
	pass
	
	
func set_targets(planet_manager : ResourceManager):
	manager.planet_target = planet_manager.planet
	manager.system_target = planet_manager.system
	manager.player_target = planet_manager.player


func add_modifier(mod : ResourceModifier):
	modifiers.append(mod)
	manager.get_group_income(mod.group).income_modifiers.append(mod)
	

func remove_modifier(mod : ResourceModifier):
	modifiers.erase(mod)
	manager.get_group_income(mod.group).income_modifiers.erase(mod)
