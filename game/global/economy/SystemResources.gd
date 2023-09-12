class_name SystemResources extends EconomyResources

const group_name = "System"
static var Type : Dictionary

func _init():
	types = Type.size()
	resource_group = ResourceModifier.Group.SYSTEM
	super._init()

static func config(config_dict : Dictionary):
	Type = config_dict.get(group_name)
