extends Control

@onready var node_prototype = preload("res://game/ui/resource_display_node.tscn")
@onready var container = $HBoxContainer

var economy : EconomyResources
var types : int
var nodes : Array[ResourceDisplayNode] = []


func _on_resource_update(context : EconomyResources) -> void:
	if context != economy:
		return
	
	for i in range(types):
		nodes[i].update_values(context.storage[i], context.income_ref.income[i])
	

func set_resource(eco : EconomyResources) -> void:
	economy = eco
	types = economy.types
	Signals.resource_update.connect(_on_resource_update)
	
	for i in range(types):
		var node = node_prototype.instantiate()		
		node.set_resource()
		nodes.append(node)
		container.add_child(node)

