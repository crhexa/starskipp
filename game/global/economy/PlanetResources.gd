class_name PlanetResources extends EconomyResources

enum Type { ENERGY, WATER, FOOD, POPULATION, STABILITY }


func _ready():
	types = Type.size()
	Utilities.set_size_zero(storage, types)
	Utilities.set_size_zero(income, types)
