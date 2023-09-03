class_name PlayerResources extends EconomyResources

enum Type { }


func _ready():
	types = Type.size()
	resource_group = ResourceModifier.ResourceGroup.PLAYER
	Utilities.set_size_zero(storage, types)
	Utilities.set_size_zero(income, types)
