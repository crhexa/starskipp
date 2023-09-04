class_name ResourceManager extends Node

var planet : EconomyIncome
var system : EconomyIncome
var player : EconomyIncome

var planet_target : EconomyIncome
var system_target : EconomyIncome
var player_target : EconomyIncome


# Denotes which group (and every group broader than it) should the manager keep track of
@export_enum("Planet", "System", "Player") var flag : int


func _ready():
	if flag > 1:
		planet = EconomyIncome.new(PlanetResources.Type.size(), ResourceModifier.ResourceGroup.PLANET)
	
	if flag > 0:
		system = EconomyIncome.new(SystemResources.Type.size(), ResourceModifier.ResourceGroup.SYSTEM)
		
	player = EconomyIncome.new(PlayerResources.Type.size(), ResourceModifier.ResourceGroup.PLAYER)


# Creates resource modifiers from an income array
func propagate(src : Array[float], tgt : Array[ResourceModifier], mod_name: StringName, group : int):
	for i in range(src.size()):
		tgt.append(ResourceModifier.new(
			mod_name, i, group, ResourceModifier.Operation.OFFSET, src[i]
		))
	
	
# Aggregate all resource modifiers from every possible group and create new offset modifiers
func process_income():
	if planet_target != null:
		planet.process_income()
		propagate(planet.income, planet_target.income_modifiers, &"Tile Income", ResourceModifier.ResourceGroup.PLANET)
		
	if system_target != null:
		system.process_income()
		propagate(system.income, system_target.income_modifiers, &"Planet Income", ResourceModifier.ResourceGroup.SYSTEM)
	
	if player_target != null:	
		player.process_income()
		propagate(player.income, player_target.income_modifiers, &"System Income", ResourceModifier.ResourceGroup.PLAYER)
	

func get_group_income(group : int) -> EconomyIncome:
	match group:
		ResourceModifier.ResourceGroup.PLANET:
			return planet
			
		ResourceModifier.ResourceGroup.SYSTEM:
			return system
			
		ResourceModifier.ResourceGroup.PLAYER:
			return player
	
	push_error("\"get_group_income()\" failed: invalid group index")
	return null
