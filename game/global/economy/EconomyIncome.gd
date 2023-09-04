class_name EconomyIncome extends Node

static var income : Array[float] = []
static var income_modifiers : Array[ResourceModifier] = []

var types : int
var resource_group : ResourceModifier.ResourceGroup


func _init(size : int, group : ResourceModifier.ResourceGroup):
	types = size
	resource_group = group


# Income is calculated as (x [offsets] * y [additive]) * z [multiplicative]
func process_income() -> void:
	var expanded : Array[Vector3] = []
	expanded.resize(types)
	expanded.fill(Vector3(0.0, 1.0, 1.0))
	
	
	for res_mod in income_modifiers:
		if res_mod.group != resource_group:
			push_error("Resource modifier group does not match resource's")
			continue
		
		match res_mod.operation:
			
			ResourceModifier.Operation.OFFSET:
				expanded[res_mod.resource].x += res_mod.value
				
			ResourceModifier.Operation.ADDITIVE:
				expanded[res_mod.resource].y += res_mod.value
				
			ResourceModifier.Operation.MULTIPLICATIVE:
				expanded[res_mod.resource].z *= res_mod.value
	
	
	for type in range(types):
		income[type] = expanded[type].x * expanded[type].y * expanded[type].z


