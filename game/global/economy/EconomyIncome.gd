class_name EconomyIncome extends Node

var income : Array[float] = []
var income_modifiers : Array[ResourceModifier] = []

var types : int
var resource_group : ResourceModifier.Group


func _init(size : int, group : ResourceModifier.Group):
	types = size
	resource_group = group
	Utilities.set_size_zero(income, types)


# Income is calculated as (x [offsets] * y [additive]) * z [multiplicative]
func process_income() -> void:
	var expanded : Array[Vector3] = []
	expanded.resize(types)
	expanded.fill(Vector3(0.0, 1.0, 1.0))
	
	
	var i = 0
	var j = income_modifiers.size()
	while i < j:
		var mod : ResourceModifier = income_modifiers[i]
		
		if mod.group != resource_group:
			push_error("Resource modifier group does not match resource's")
			continue
		
		match mod.operation:
			
			ResourceModifier.Operation.OFFSET:
				expanded[mod.resource].x += mod.value
				
			ResourceModifier.Operation.ADDITIVE:
				expanded[mod.resource].y += mod.value
				
			ResourceModifier.Operation.MULTIPLICATIVE:
				expanded[mod.resource].z *= mod.value
	
		if ResourceModifier.tick(mod):
			income_modifiers.remove_at(i)
			j -= 1
			
		else:
			i += 1
		
	for type in range(types):
		income[type] = expanded[type].x * expanded[type].y * expanded[type].z


# Same as process_income() but for use outside of the normal processing step
func update_income(resources : EconomyResources) -> void:
	var expanded : Array[Vector3] = []
	expanded.resize(types)
	expanded.fill(Vector3(0.0, 1.0, 1.0))
	
	
	var i = 0
	var j = income_modifiers.size()
	while i < j:
		var mod : ResourceModifier = income_modifiers[i]
		
		if mod.group != resource_group:
			push_error("Resource modifier group does not match resource's")
			continue
		
		match mod.operation:
			
			ResourceModifier.Operation.OFFSET:
				expanded[mod.resource].x += mod.value
				
			ResourceModifier.Operation.ADDITIVE:
				expanded[mod.resource].y += mod.value
				
			ResourceModifier.Operation.MULTIPLICATIVE:
				expanded[mod.resource].z *= mod.value
		
	for type in range(types):
		income[type] = expanded[type].x * expanded[type].y * expanded[type].z


	# Send the signal to update the resource display
	Signals.resource_update.emit(resources)
	
