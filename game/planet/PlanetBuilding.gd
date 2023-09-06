class_name PlanetBuilding extends Node

var tile : PlanetTile
var modifiers : Array[ResourceModifier] = []

@export var progress : int
@export_range(0.0, 1.0) var effectiveness : float = 1.0


func _ready():
	Signals.day_passed.connect(_on_day_passed)


func _on_day_passed():
	pass
	

# Remove and free any building linked modifiers from the tile's modifiers
func free():
	for mod in modifiers:
		tile.modifiers.erase(mod)
	
	queue_free()
