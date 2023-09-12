extends Node

const types : String = "res://data/resource_types.json"
var placeholder : PlaceholderTexture2D = PlaceholderTexture2D.new()
var types_dict : Dictionary


func _init():
	load_resource_types()
	

func load_resource_types() -> void:
	if not FileAccess.file_exists(types):
		# CTD gracefully and log error
		push_error("J")
		Utilities.signal_termination(get_tree())
		pass
		
	var file = FileAccess.open(types, FileAccess.READ)
	var json = JSON.new()
	var error = json.parse(file.get_as_text())
	
	if error != OK:
		push_error("J")
		Utilities.signal_termination(get_tree())
		
	if typeof(json.data) != TYPE_DICTIONARY:
		# CTD and log json unexpected type error
		push_error("J")
		Utilities.signal_termination(get_tree())
		
	types_dict = json.data 
	for group in range(ResourceModifier.Group.size()):
		var group_class = ResourceModifier.get_group_ref(group)
		var group_dict : Dictionary = types_dict.get(group_class.group_name)
		
		if group_dict == null:
			# CTD and log missing dict key error
			push_error("J")
			Utilities.signal_termination(get_tree())
		
		if typeof(group_dict) != TYPE_DICTIONARY:
			# CTD and log json unexpected type error
			push_error("J")
			Utilities.signal_termination(get_tree())
		
		group_class.config(types_dict)
		for key in group_class.Type:
			var type = group_class.Type[key]
			if typeof(type) != TYPE_DICTIONARY:
				# CTD and log json unexpected type error
				push_error("J")
				Utilities.signal_termination(get_tree())
				
			load_icon(type)
		

func load_icon(dict : Dictionary) -> void:
	var icon_path = dict.get("icon_path")
	if icon_path != null and icon_path != "":
		dict["icon"] = load(icon_path)
			
	else:
		dict["icon"] = placeholder
	
