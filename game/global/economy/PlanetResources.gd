class_name PlanetResources extends EconomyResources

enum Type { ENERGY, WATER, FOOD, POPULATION, STABILITY }


func _init():
	types = Type.size()
	resource_group = ResourceModifier.ResourceGroup.PLANET
	super._init()
