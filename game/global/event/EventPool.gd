extends Node

var objects : Dictionary = {}
var activated : Array[EventObject]


func lookup(id : String) -> EventObject:
	return objects.get(id) as EventObject


func define(id : String, obj : EventObject):
	if lookup(id) != null:
		push_error("Attempted to redefine existing EventObject: %s" % id)
		return
		
	objects[id] = obj


# Adds an EventObject to the list of currently activated events
func activate(id : String):
	var obj = lookup(id)
	if obj == null:
		push_error("EventObject not found: %s" % id)
		return
		
	if not activated.has(obj):
		activated.push_back(obj)


# Removes an EventObject to the list of currently activated events
func deactivate(id : String):
	var obj = lookup(id)
	if obj == null:
		push_error("EventObject not found: %s" % id)
		return
		
	activated.erase(obj)


# Makes random probability checks to execute every activated event
func random_check() -> void:
	for i in range(activated.size()-1, -1, -1):
		var event = activated[i]
		var probability = 1.0 / event.mtte
		
		if (event.mtte <= 1) or (probability >= randf()):
			event.execute()
			activated.remove_at(i)

