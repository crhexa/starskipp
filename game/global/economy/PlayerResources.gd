class_name PlayerResources extends EconomyResources

enum Type { }


func _init():
	types = Type.size()
	resource_group = ResourceModifier.ResourceGroup.PLAYER
	super._init()
