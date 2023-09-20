class_name Star extends Node2D


# Determines the properties of the surrounding planets
enum SpectralClass {EMPTY, CLASS_O, CLASS_B, CLASS_A, CLASS_F, CLASS_G, CLASS_K, CLASS_M}

var properties = {
	"Spectral Class" : SpectralClass.EMPTY,		# Harvard system classification
	"Effective Temperature" : -1,				# In Kelvin
	"Mass" : -1,								# In solar masses (2 * 10^30 kg)
}



func _ready():
	$SMSelector.set_outline_radius($MainShader.size.x * 0.5)
	$MainShader.material.set_shader_parameter("time", 0)


func _process(_delta):
	$MainShader.material.set_shader_parameter("time", TimeController.time * 0.1)
