class_name ResearchParser extends EventParser


func _init():
	placeholder = PlaceholderTexture2D.new()
	type_error = "ResearchObject JSON type error: expected value of type %s for key \"%s\""
	

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
		
		var type = entry["type"]
		if typeof(type) != TYPE_STRING:
			push_warning(type_error % ["String", "type"])
			continue
			
		var hidden = entry["hidden"]
		if typeof(hidden) != TYPE_BOOL:
			push_warning(type_error % ["Bool", "hidden"])
			continue
			
		var activation = entry["activation"]
		if typeof(activation) != TYPE_STRING:
			push_warning(type_error % ["String", "activation"])
			continue
			
		var resource_cost = entry["resource_cost"]
		if typeof(resource_cost) != TYPE_DICTIONARY:
			push_warning(type_error % ["Dictionary", "resource_cost"])
			continue
			
		var progress = entry["progress"]
		if typeof(progress) != TYPE_FLOAT:
			push_warning(type_error % ["Float", "progress"])
			continue
		
		var effect = entry["effect"]
		if typeof(effect) != TYPE_ARRAY:
			push_warning(type_error % ["Array", "effect"])
			continue
			
		var icon_path = entry["icon_path"]
		if typeof(icon_path) != TYPE_STRING:
			push_warning(type_error % ["String", "icon_path"])
			continue
			
		var description = entry["description"]
		if typeof(description) != TYPE_STRING:
			push_warning(type_error % ["String", "description"])
			continue
		
		
		var obj := ResearchObject.new()
		obj.title = title
		obj.type = type
		obj.hidden = hidden
		obj.progress = progress
		obj.description = description
		
		# Parse String -> Expr
		var expr = ExprParser.parse(activation)
		if expr == null:
			push_warning("ResearchObject: failed to parse Expr from field \"activation\"")
			continue
		obj.activation = expr
		
		# Parse Dictionary -> ResourceModifiers
		var mods : Array[ResourceModifier] = ResModParser.parse(resource_cost)
		obj.resource_cost = mods
		
		# Parse Strings -> ExprEffects
		var effects : Array[ExprEffect] = ExprParser.parse_effects(effect)
		obj.effect = effects
		
		# Load icon if exists
		if icon_path.is_empty():
			obj.icon = placeholder
			
		else:
			var texture = load(icon_path)
			if texture != null:
				obj.icon = texture
				
			else:
				obj.icon = placeholder
		
		# Add to ResearchPool
		ResearchPool.define(key, obj)
