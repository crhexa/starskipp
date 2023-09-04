class_name PlanetTile extends Node

enum Flags {}

var primary_resource : ResourceModifier
var primary_richness : float

var modifiers : Array[ResourceModifier] = []
var flags : Array[Flags] = []

var building_primary : PlanetBuilding
var building_buffer : PlanetBuilding


func _ready():
	Signals.day_passed.connect(_on_day_passed)


func _init(res : int, res_group : ResourceModifier.ResourceGroup, rich : float):
	primary_richness = rich
	primary_resource = ResourceModifier.new(
		&"BaseTileExtract", res, res_group, ResourceModifier.Operation.OFFSET, primary_richness
		)
	modifiers.append(primary_resource)
	

func _on_day_passed():
	pass


