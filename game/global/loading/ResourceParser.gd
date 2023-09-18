class_name ResourceParser extends Node

var placeholder := PlaceholderTexture2D.new()
var loaded : Dictionary


func load_types(fp : String) -> bool:
	if not FileAccess.file_exists(fp):
		# CTD gracefully and log error
		push_error("todo")
		return false
		
	var file = FileAccess.open(fp, FileAccess.READ)
	var json = JSON.new()
	var error = json.parse(file.get_as_text())
	
	if error != OK:
		push_error("todo")
		return false
		
	if typeof(json.data) != TYPE_DICTIONARY:
		# CTD and log json unexpected type error
		push_error("todo")
		return false
		
	loaded = json.data 
	for group in range(ResourceModifier.Group.size()):
		var group_class = ResourceModifier.get_group_ref(group)
		var group_dict : Dictionary = loaded.get(group_class.group_name)
		
		if group_dict == null:
			# CTD and log missing dict key error
			push_error("todo")
			return false
		
		if typeof(group_dict) != TYPE_DICTIONARY:
			# CTD and log json unexpected type error
			push_error("todo")
			return false
		
		group_class.config(loaded)
		for key in group_class.Type:
			var type = group_class.Type[key]
			if typeof(type) != TYPE_DICTIONARY:
				# CTD and log json unexpected type error
				push_error("todo")
				return false
				
			load_icon(type)
	
	return true
		

func load_icon(dict : Dictionary) -> void:
	var icon_path = dict.get("icon_path")
	if icon_path != null and icon_path != "":
		dict["icon"] = load(icon_path)
			
	else:
		dict["icon"] = placeholder
	
