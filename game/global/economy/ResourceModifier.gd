class_name ResourceModifier

enum ResourceGroup { PLANET, SYSTEM, PLAYER }
enum Operation { OFFSET, ADDITIVE, MULTIPLICATIVE }


# The name (source) of the modifier
var name : StringName

# The resource being modified
var resource : int

# What object the resource is associated with
var group : ResourceGroup

# How the resource will be modified
var operation : Operation

# How much the resource will be modified
var value : float


func _init(n : StringName, res : int, res_group : ResourceGroup, op : Operation, val : float):
	name = n
	resource = res
	group = res_group
	operation = op
	value = val
