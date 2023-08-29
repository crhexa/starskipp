extends Control

@onready var subpanel_prototype = preload("res://game/ui/subpanel.tscn")


func _ready():
	Signals.system_object_clicked.connect(_on_system_object_clicked)


func create_subpanel(context = null):
	var subpanel = subpanel_prototype.instantiate()
	add_child(subpanel)
	
	# set subpanel context
	
	subpanel.show()


func _on_system_object_clicked():
	# TODO: avoid duplicate panels per context
	create_subpanel()
