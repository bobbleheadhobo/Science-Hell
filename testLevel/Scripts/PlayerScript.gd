extends CharacterBody2D

@export var speed = 300
@export var gravity = 10
@export var jumpForce = 450
@export var theAcc = 1
var prevDir = 0
var horizontalDirection = -2

func _physics_process(delta):
	
	if speed > 999:
		speed = 999
	
	if(!is_on_floor()):
		
		velocity.y += gravity
		
		if velocity.y > 999:
			velocity.y = 999
		
			
	if(Input.is_action_just_pressed("jump")):
		velocity.y = -jumpForce
	
	
	
	if(prevDir == horizontalDirection && horizontalDirection != 0):
		theAcc += 0.1
		speed += theAcc * 10
		velocity.x = speed * horizontalDirection
	else:
		theAcc = 1
		speed = 300
		velocity.x = speed * horizontalDirection
	
	horizontalDirection = Input.get_axis("moveLeft", "moveRight")
	prevDir = horizontalDirection
	
	velocity.x = speed * horizontalDirection
	set_velocity(velocity)
	move_and_slide()
	
	print("Direction: ", horizontalDirection)
	print("Acceleration: ", theAcc)
	print("Speed: ", speed)
