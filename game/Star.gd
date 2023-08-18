class_name Star
extends Area2D

enum Class {CLASS_O, CLASS_B, CLASS_A, CLASS_F, CLASS_G, CLASS_K, CLASS_M}
var type

func _ready():
	pass


func _process(_delta):
	$MainShader.material.set_shader_parameter("time", TimeController.time * 0.1)
