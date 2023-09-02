class_name SystemResources extends EconomyResources

enum Type { BULK_MINERALS, HALOGENS, VOLATILES, NOBLE_METALS, NOBLE_GASES, PLATINOIDS, RADIOISOTOPES }


func _ready():
	types = Type.size()
	Utilities.set_size_zero(storage, types)
	Utilities.set_size_zero(income, types)

