class_name ResearchParser extends EventParser

@onready var placeholder = PlaceholderTexture2D.new()


func parse_json(dict : Dictionary) -> bool:
	for key in dict.keys():
		var entry = dict[key]
		if typeof(entry) != TYPE_DICTIONARY:
			push_warning("ResearchObject JSON type error: expected Dictionary")
			continue
		
		# Verify the correct data type for each field
		var type = entry["type"]
		if typeof(type) != TYPE_STRING:
			push_warning("ResearchObject JSON type error: expected String")
			continue
			
		var hidden = entry["hidden"]
		if typeof(hidden) != TYPE_BOOL:
			push_warning("ResearchObject JSON type error: expected Bool")
			continue
			
		var activation = entry["activation"]
		if typeof(activation) != TYPE_STRING:
			push_warning("ResearchObject JSON type error: expected String")
			continue
			
		var resource_cost = entry["resource_cost"]
		if typeof(resource_cost) != TYPE_DICTIONARY:
			push_warning("ResearchObject JSON type error: expected Dictionary")
			continue
			
		var progress = entry["progress"]
		if typeof(progress) != TYPE_FLOAT:
			push_warning("ResearchObject JSON type error: expected Float")
			continue
		
		var effect = entry["effect"]
		if typeof(effect) != TYPE_ARRAY:
			push_warning("ResearchObject JSON type error: expected Array")
			continue
			
		var icon_path = entry["icon_path"]
		if typeof(icon_path) != TYPE_STRING:
			push_warning("ResearchObject JSON type error: expected String")
			continue
			
		var description = entry["description"]
		if typeof(description) != TYPE_STRING:
			push_warning("ResearchObject JSON type error: expected String")
			continue
		
		
		var obj := ResearchObject.new()
		obj.type = type
		obj.hidden = hidden
		obj.progress = progress
		obj.description = description
		
		var expr = ExprParser.parse(activation)
		if expr == null:
			continue
		obj.activation = expr
		
		var mods = ResModParser.parse(resource_cost)
		obj.resource_cost = mods
		
		var effects = ExprParser.parse_effects(effect)
		obj.effect = effects
		
		if icon_path.is_empty():
			obj.icon = placeholder
			
		else:
			var texture = load(icon_path)
			if texture != null:
				obj.icon = texture
				
			else:
				obj.icon = placeholder
		
		ResearchPool.define(key, obj)
		
	return true
