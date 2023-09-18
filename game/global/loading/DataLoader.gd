extends Node

@onready var resource := ResourceParser.new()
@onready var research := ResearchParser.new()
@onready var event := EventParser.new()


func load_data() -> bool:
	var valid = true
	
	valid = valid and resource.load_types("res://data/resource_types.json")
		
	valid = valid and research.load_dir("res://data/research")
		
	valid = valid and event.load_dir("res://data/events")
		
	return valid
