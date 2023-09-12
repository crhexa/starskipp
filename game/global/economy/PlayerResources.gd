class_name PlayerResources extends EconomyResources

const group_name = "Player"
static var Type : Dictionary

func _init():
	types = Type.size()
	resource_group = ResourceModifier.Group.PLAYER
	super._init()

static func config(config_dict : Dictionary):
	Type = config_dict.get(group_name)
