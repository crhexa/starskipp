extends Node

var objects : Dictionary = {}
var enhancements : Dictionary = {}
var precepts : Dictionary = {}


func lookup(id : String) -> ResearchObject:
	return objects.get(id) as ResearchObject



func define(id : String, obj : ResearchObject) -> void:
	if lookup(id) != null:
		push_error("Attempted to redefine existing ResearchObject in pool")
		return
		
	objects[id] = obj
	if obj.type == "ENHANCEMENT":
		enhancements[id] = obj
		
	elif obj.type == "PRECEPT":
		precepts[id] = obj
	
