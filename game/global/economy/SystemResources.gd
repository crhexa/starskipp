class_name SystemResources extends EconomyResources

enum Type { BULK_MINERALS, HALOGENS, VOLATILES, NOBLE_METALS, NOBLE_GASES, PLATINOIDS, RADIOISOTOPES }


func _init():
	types = Type.size()
	resource_group = ResourceModifier.ResourceGroup.SYSTEM
	super._init()
	
