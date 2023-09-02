class_name ResourceModifier

enum ResourceType { PLANET, SYSTEM, PLAYER }
enum Operation { OFFSET, ADDITIVE, MULTIPLICATIVE }


# The name (source) of the modifier
var name : StringName

# The resource being modified
var resource : int

# The type of the resource being modified
var resource_type : ResourceType

# How the resource will be modified
var operation : Operation

# How much the resource will be modified
var value : float


func _init(n : StringName, res : int, res_type : ResourceType, op : Operation, val : float):
	name = n
	resource = res
	resource_type = res_type
	operation = op
	value = val
