class_name PlanetResources extends EconomyResources

const group_name = "Planet"
static var Type : Dictionary

func _init():
	types = Type.size()
	resource_group = ResourceModifier.Group.PLANET
	super._init()
	
static func config(config_dict : Dictionary):
	Type = config_dict.get(group_name)
	
