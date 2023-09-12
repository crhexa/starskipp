class_name ResourceManager extends Node

var planet : EconomyIncome
var system : EconomyIncome
var player : EconomyIncome

var planet_target : Array[ResourceModifier]
var system_target : Array[ResourceModifier]
var player_target : Array[ResourceModifier]


# Denotes which group (and every group broader than it) should the manager keep track of
@export_enum("Planet", "System", "Player") var flag : int


func _ready():
	if flag < 1:
		planet = EconomyIncome.new(PlanetResources.Type.size(), ResourceModifier.Group.PLANET)
	
	if flag < 2:
		system = EconomyIncome.new(SystemResources.Type.size(), ResourceModifier.Group.SYSTEM)
		
	player = EconomyIncome.new(PlayerResources.Type.size(), ResourceModifier.Group.PLAYER)


# Creates resource modifiers from an income array
func propagate(src : Array[float], tgt : Array[ResourceModifier], mod_name: StringName, group : int):
	for i in range(src.size()):
		if is_zero_approx(src[i]):
			continue
			
		tgt.append(ResourceModifier.new( 
			mod_name, i, group, ResourceModifier.Operation.OFFSET, src[i], 1
		))
	
	
# Aggregate all resource modifiers from every possible group and create new offset modifiers
func process_income():
	if planet != null and planet_target != null:
		planet.process_income()
		propagate(planet.income, planet_target, &"Tile Income", ResourceModifier.Group.PLANET)
		
	if system != null and system_target != null:
		system.process_income()
		propagate(system.income, system_target, &"Planet Income", ResourceModifier.Group.SYSTEM)
	
	if player != null and player_target != null:	
		player.process_income()
		propagate(player.income, player_target, &"System Income", ResourceModifier.Group.PLAYER)
	

func get_group_income(group : int) -> EconomyIncome:
	match group:
		ResourceModifier.Group.PLANET:
			return planet
			
		ResourceModifier.Group.SYSTEM:
			return system
			
		ResourceModifier.Group.PLAYER:
			return player
	
	push_error("\"get_group_income()\" failed: invalid group index")
	return null
