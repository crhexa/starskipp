extends Node

var tiles : Array[PlanetTile]

func _ready():
	for tile in tiles:
		tile.set_targets($ResourceManager)


func process_resources():
	for tile in tiles:
		tile.process_resources()
