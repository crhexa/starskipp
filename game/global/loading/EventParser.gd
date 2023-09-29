class_name EventParser extends Node

var type_error : String
var placeholder : PlaceholderTexture2D


func _init():
	placeholder = PlaceholderTexture2D.new()
	type_error = "EventObject JSON type error: expected value of type %s for key \"%s\""
	
	
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
		
	self.parse_json(json.data)
	return true


func parse_json(dict : Dictionary) -> void:
	for key in dict.keys():
		var entry = dict[key]
		if typeof(entry) != TYPE_DICTIONARY:
			push_warning(type_error % ["Dictionary", key])
			continue
		
		# Verify the correct data type for each field
		var title = entry["title"]
		if typeof(title) != TYPE_STRING:
			push_warning(type_error % ["String", "title"])
			continue
		
		var text = entry["text"]
		if typeof(text) != TYPE_STRING:
			push_warning(type_error % ["String", "text"])
			continue
		
		var executed = entry["executed"]
		if typeof(executed) != TYPE_BOOL:
			push_warning(type_error % ["Bool", "executed"])
			continue
		
		var trigger = entry["trigger"]
		if typeof(trigger) != TYPE_STRING:
			push_warning(type_error % ["String", "trigger"])
			continue
		
		var mtte = entry["mtte"]
		if typeof(mtte) != TYPE_FLOAT:
			push_warning(type_error % ["Float", "mtte"])
			continue
		
		var image_path = entry["image_path"]
		if typeof(image_path) != TYPE_STRING:
			push_warning(type_error % ["String", "image_path"])
			continue
		
		var responses = entry["responses"]		
		if typeof(responses) != TYPE_DICTIONARY:
			push_warning(type_error % ["Dictionary", "responses"])
			continue
			
		
		var obj : EventObject = EventObject.new()
		obj.title = title
		obj.text = text
		obj.executed = executed
		obj.mtte = int(mtte)		
		
		# Parse String -> Expr
		var expr : Expr = ExprParser.parse(trigger)
		if expr == null:
			push_warning("EventObject: failed to parse Expr from field \"trigger\"")
			continue
		obj.trigger = expr
		
		# Parse String -> EventResponses
		var event_responses : Array[EventObject.EventResponse] = parse_responses(responses)
		if event_responses.is_empty():
			push_warning("EventObject: failed to parse any EventResponses")
			continue
		obj.responses = event_responses
		
		# Load image if exists
		if image_path.is_empty():
			obj.image = placeholder
			
		else:
			var texture = load(image_path)
			if texture != null:
				obj.image = texture
				
			else:
				obj.image = placeholder
		
		# Add to EventPool
		EventPool.define(key, obj)


func parse_responses(responses : Dictionary) -> Array[EventObject.EventResponse]:
	var _type_error : String = "EventResponse JSON type error: expected value of type %s for key \"%s\""
	var result : Array[EventObject.EventResponse] = []
	
	for key in responses.keys():
		var response = responses[key]
		if typeof(response) != TYPE_DICTIONARY:
			push_warning(_type_error % ["", key])
			continue
		
		# Verify the correct data type for each field
		var text = response["text"]
		if typeof(text) != TYPE_STRING:
			push_warning(_type_error % ["String", "text"])
			continue
		
		var tooltip = response["tooltip"]
		if typeof(tooltip) != TYPE_STRING:
			push_warning(_type_error % ["String", "tooltip"])
			continue
	
		var condition = response["condition"]
		if typeof(condition) != TYPE_STRING:
			push_warning(_type_error % ["String", "condition"])
			continue
		
		var effect = response["effect"]
		if typeof(effect) != TYPE_ARRAY:
			push_warning(_type_error % ["Array", "effect"])
			continue
		
		var resource_effect = response["resource_effect"]
		if typeof(resource_effect) != TYPE_DICTIONARY:
			push_warning(_type_error % ["Dictionary", "resource_effect"])
			continue
			
		
		var obj : EventObject.EventResponse = EventObject.EventResponse.new()
		obj.text = text
		obj.tooltip = tooltip
		
		# Parse String -> Expr
		var expr : Expr = ExprParser.parse(condition)
		if expr == null:
			push_warning("EventResponse: failed to parse Expr from field \"condition\"")
			continue
		obj.condition = expr
		
		# Parse Strings -> ExprEffects
		var effects : Array[ExprEffect] = ExprParser.parse_effects(effect)
		obj.effect = effects
			
		# Parse Dictionary -> ResourceModifiers
		var mods : Array[ResourceModifier] = ResModParser.parse(resource_effect)
		obj.resource_effect = mods
		
		result.push_back(obj)
		
	return result
