extends Area2D


@export var acceleration = 100
@export var turning_speed = 1

var velocity = Vector2.ZERO
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	# Handle player inputs
	if Input.is_action_pressed("accelerate"):
		velocity += (delta * acceleration * Vector2.UP.rotated(rotation))
		$AnimatedSprite2D.set_frame(1)
	else:
		$AnimatedSprite2D.set_frame(0)
		
	if Input.is_action_pressed("turn_left"):
		rotation -= turning_speed * delta
		
	if Input.is_action_pressed("turn_right"):
		rotation += turning_speed * delta
	
	if Input.is_action_pressed("decelerate"):
		pass
	
	position += velocity * delta
	
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
	
