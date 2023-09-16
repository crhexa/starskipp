extends Node

var objects : Dictionary = {}
var enhancements : Dictionary = {}
var precepts : Dictionary = {}


func lookup(id : String) -> ResearchObject:
	return objects.get(id) as ResearchObject


func define(id : String, obj : ResearchObject):
	if lookup(id) != null:
		push_error("Attempted to redefine existing ResearchObject in pool")
		return
		
	objects[id] = obj
	if obj is ResearchObject.EnhanceObject:
		enhancements[id] = objects
		
	elif obj is ResearchObject.PreceptObject:
		precepts[id]
	
