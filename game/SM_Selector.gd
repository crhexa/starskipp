extends Area2D

@export var outline_radius : int = 100
@export var width : int = 3
@export var detail : int = 64
@export var highlight_color : Color
@export var normal_color : Color

@onready var collider = $CollisionShape2D

var color : Color


func _ready():
	collider.shape.radius = outline_radius
	color = normal_color
	

func _draw():
	draw_arc(collider.position, outline_radius, 0.0, TAU, detail, color, width, true)
	

func _on_mouse_entered():
	color = highlight_color
	queue_redraw()


func _on_mouse_exited():
	color = normal_color
	queue_redraw()

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:

			# mouse interaction code here
			print("clicked!")
			

func set_outline_radius(rad : int):
	outline_radius = rad
	collider.shape.radius = rad

