class_name ResourceModifier extends RefCounted

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

# The number of ticks the modifier will exist for
var duration : int


func _init(n : StringName, r : int, rg : ResourceGroup, o : Operation, v : float, d : int):
	name = n
	resource = r
	group = rg
	operation = o
	value = v
	duration = d


# Returns true if the modifier was deleted
static func tick(mod : ResourceModifier) -> bool:
	
	# persistent -> duration == INT_MAX
	#   one-time -> duration == 1
	if mod.duration != Utilities.INT_MAX:
		mod.duration -= 1
		
		if mod.duration < 1:
			return true
	
	return false
	
	
	
