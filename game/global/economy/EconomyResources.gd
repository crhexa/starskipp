class_name EconomyResources extends Node

var storage : Array[float] = []
var storage_modifiers : Array[ResourceModifier] = []

var income_ref : EconomyIncome

# Defined by child classes
var types : int
var resource_group : ResourceModifier.ResourceGroup


func _init():
	# "types" should be initialized in the child class before calling this method
	Utilities.set_size_zero(storage, types)
	
	
# Storage is calculated as (storage + additive) + offsets
func process_storage(inc : EconomyIncome) -> void:
	var expanded : Array[Vector2] = []
	expanded.resize(types)
	expanded.fill(Vector2(0.0, 1.0))
	
	var i = 0
	var j = storage_modifiers.size()
	while i < j:
		var mod : ResourceModifier = storage_modifiers[i]
		
		if mod.group != resource_group:
			push_error("Resource modifier group does not match resource's")
			continue
		
		match mod.operation:
			
			# Check for invalid multiplicative operation
			ResourceModifier.Operation.MULTIPLICATIVE:
				push_error("Invalid multiplicative storage modifier linked to " + mod.name)
				
			ResourceModifier.Operation.OFFSET:
				expanded[mod.resource].x += mod.value
				
			ResourceModifier.Operation.ADDITIVE:
				expanded[mod.resource].y += mod.value
	
		if ResourceModifier.tick(mod):
			storage_modifiers.remove_at(i)
			j -= 1
			
		else:
			i += 1
	
	for type in range(types):
		storage[type] = expanded[type].x + (expanded[type].y * storage[type]) + inc.income[type]
	
	income_ref = inc
	Signals.resource_update.emit(self)
			
