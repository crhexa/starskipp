extends Node

func parse(dict : Dictionary) -> Array[ResourceModifier]:
	var arr : Array[ResourceModifier] = []
	
	for key in dict.keys():
		if typeof(dict[key]) != TYPE_DICTIONARY:
			push_warning("ResModParser failed parsing array: expected Dictionary")
			return []
			
		var modifier = parse_modifier(dict[key], key)
		if modifier == null:
			push_warning("ResModParser failed parsing modifier: \"%s\"" % key)
			continue
			
		arr.push_back(modifier)
		
	return arr


func parse_modifier(dict : Dictionary, mod_name : String) -> ResourceModifier:
	var resource = dict["resource"]
	if typeof(resource) != TYPE_FLOAT:
		return null
		
	var group = dict["group"]
	if typeof(group) != TYPE_FLOAT:
		return null
		
	var operation = dict["operation"]
	if typeof(operation) != TYPE_FLOAT:
		return null
		
	var value = dict["value"]
	if typeof(value) != TYPE_FLOAT:
		return null
		
	var duration = dict["duration"]
	if typeof(duration) != TYPE_FLOAT:
		return null
	
	var modifier : ResourceModifier = ResourceModifier.new(
		mod_name, int(resource), int(group), int(operation), value, int(duration)
	)
	
	return modifier
