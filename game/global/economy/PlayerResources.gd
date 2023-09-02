class_name PlayerResources extends EconomyResources

enum Type { }


func _ready():
	types = Type.size()
	Utilities.set_size_zero(storage, types)
	Utilities.set_size_zero(income, types)
