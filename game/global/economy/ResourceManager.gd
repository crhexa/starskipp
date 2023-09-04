# Aggregates income from sources at the same level as the manager,
# and propagates applicable resource incomes to a higher level as a new resource modifier
class_name ResourceManager extends Node

var planet : EconomyIncome
var system : EconomyIncome
var player : EconomyIncome

# Denotes which group (and every group broader than it) should the manager keep track of
@export_enum("Planet", "System", "Player") var flag : int


func _ready():
	if flag > 1:
		planet = EconomyIncome.new(PlanetResources.Type.size(), ResourceModifier.ResourceGroup.PLANET)
	
	if flag > 0:
		system = EconomyIncome.new(SystemResources.Type.size(), ResourceModifier.ResourceGroup.SYSTEM)
		
	player = EconomyIncome.new(PlayerResources.Type.size(), ResourceModifier.ResourceGroup.PLAYER)
