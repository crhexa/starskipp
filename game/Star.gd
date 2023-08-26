class_name Star
extends Node2D


enum SpectralClass {CLASS_O, CLASS_B, CLASS_A, CLASS_F, CLASS_G, CLASS_K, CLASS_M}
var type : SpectralClass


func _ready():
	$SMSelector.set_outline_radius($MainShader.size.x * 0.6 * scale.x)


func _process(_delta):
	$MainShader.material.set_shader_parameter("time", TimeController.time * 0.1)
