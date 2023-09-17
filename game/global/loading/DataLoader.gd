extends Node

@onready var resource := ResourceParser.new()
@onready var research := ResearchParser.new()
@onready var event := EventParser.new()


func load_data() -> bool:
	var error = false
	
	error = error or resource.load_types("res://data/resource_types.json")
		
	error = error or research.load_objects("res://data/research")
		
	error = error or event.load_objects("res://data/events")
		
	return error
