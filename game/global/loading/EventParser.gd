class_name EventParser extends Node


func load_dir(dir_path : String) -> bool:
	var dir = DirAccess.open(dir_path)
	if not dir:
		push_error("Unable to open directory: %s" % dir_path)
		return false
		
	var files = dir.get_files()
	for file_name in files:
		if file_name.ends_with(".json"):
			load_json(dir_path + "/" + file_name)
		
	return true


func load_json(file_path : String) -> bool:
	var file = FileAccess.open(file_path, FileAccess.READ)
	var json = JSON.new()
	var error = json.parse(file.get_as_text())
	
	if error != OK:
		push_error("todo")
		return false
		
	if typeof(json.data) != TYPE_DICTIONARY:
		push_error("todo")
		return false
		
	return self.parse_json(json.data)


func parse_json(dict : Dictionary) -> bool:
	return true
