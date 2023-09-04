class_name EconomyResources extends Node

static var storage : Array[float] = []
static var storage_modifiers : Array[ResourceModifier] = []
static var eco_inc : EconomyIncome

# Defined by child classes
var types : int
var resource_group : ResourceModifier.ResourceGroup


func _init():
	# "types" should be initialized in the child class before calling this method
	Utilities.set_size_zero(storage, types)
	eco_inc = new_income()
	

# Storage is calculated as (storage + additive) + offsets
func process_storage() -> void:
	var expanded : Array[Vector2] = []
	expanded.resize(types)
	expanded.fill(Vector2(0.0, 1.0))
	
	
	for res_mod in storage_modifiers:
		if res_mod.group != resource_group:
			push_error("Resource modifier group does not match resource's")
			continue
		
		match res_mod.operation:
			
			# Check for invalid multiplicative operation
			ResourceModifier.Operation.MULTIPLICATIVE:
				push_error("Invalid multiplicative storage modifier linked to " + res_mod.name)
				
			ResourceModifier.Operation.OFFSET:
				expanded[res_mod.resource].x += res_mod.value
				
			ResourceModifier.Operation.ADDITIVE:
				expanded[res_mod.resource].y += res_mod.value
	
	
	for type in range(types):
		storage[type] = expanded[type].x + (expanded[type].y * storage[type]) + eco_inc.income[type]
			

func new_income() -> EconomyIncome:
	var foo = EconomyIncome.new(types, resource_group)
	Utilities.set_size_zero(foo.income, types)
	return foo
