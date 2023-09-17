extends Node

@onready var play_scene = preload("res://game/system.tscn")
@onready var main_menu = $MainMenu


func _ready():
	if not DataLoader.load_data():
		# data loading error, crash!
		Utilities.signal_termination(get_tree())
	

func _on_play_button_up():
	var play = play_scene.instantiate()
	remove_child(main_menu)
	add_child(play)
