extends Area2D

# Privately accessed properties
var screen_size

# Publicly accessed properties
var velocity: Vector2 = Vector2.ZERO
var rads: float = 0							# Rotation angle in radians
var diff: float = 0							# Difference in angle between velocity and rotation
var speed: float = 0						# Magnitude of velocity vector

# Editor properties
@export var acceleration: float = 98
@export var turning_speed: float = 1



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	# Update public variables
	rads = fposmod(rotation - (PI / 2), TAU)
	diff = velocity.rotated(TAU).angle_to(Vector2.from_angle(rads))
	speed = velocity.length_squared()


	# Handle player inputs
	if Input.is_action_pressed("accelerate"):
		velocity += (delta * acceleration * Vector2.UP.rotated(rotation))
		$AnimatedSprite2D.set_frame(1)
	else:
		$AnimatedSprite2D.set_frame(0)
		
	
	if Input.is_action_pressed("deccelerate") and not velocity.is_zero_approx():
		if diff > 0:
			rotation += clamp(abs(diff), 0, turning_speed * delta)
		else:
			rotation -= clamp(abs(diff), 0, turning_speed * delta)
			
	else:
		if Input.is_action_pressed("turn_left"):
			rotation -= turning_speed * delta
		if Input.is_action_pressed("turn_right"):
			rotation += turning_speed * delta
	
	position += velocity * delta
	
	
	
	# Update player ship GUI
	$Camera2D/CanvasLayer/Label.text = str(snappedf(diff, 0.1)) + " / " + str(snappedf(rads, 0.1))
		
	$BGStarEffect.speed_scale = clamp(log(speed), 0.01, 60)
	
	
	
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
