class_name EconomyResources extends Node

static var storage : Array[float] = []
static var income : Array[float] = []
static var storage_modifiers : Array[ResourceModifier] = []
static var income_modifiers : Array[ResourceModifier] = []

static var types : int

# Income is calculated as (x [offsets] * y [additive]) * z [multiplicative]
func process_income() -> void:
	var expanded : Array[Vector3] = []
	expanded.resize(types)
	expanded.fill(Vector3(0.0, 1.0, 1.0))
	
	
	for res_mod in income_modifiers:
		match res_mod.operation:
			ResourceModifier.Operation.OFFSET:
				expanded[res_mod.resource].x += res_mod.value
				
			ResourceModifier.Operation.ADDITIVE:
				expanded[res_mod.resource].y += res_mod.value
				
			ResourceModifier.Operation.MULTIPLICATIVE:
				expanded[res_mod.resource].z *= res_mod.value
	
	
	for type in range(types):
		income[type] = expanded[type].x * expanded[type].y * expanded[type].z


# Storage is calculated as (storage + additive) + offsets
func process_storage() -> void:
	for res_mod in storage_modifiers:
		
		# Check for invalid multiplicative operation
		if res_mod.operation == ResourceModifier.Operation.MULTIPLICATIVE:
			push_error("Invalid multiplicative storage modifier linked to " + res_mod.name)
		
		
