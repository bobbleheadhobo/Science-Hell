extends CharacterBody2D

@export var speed = 300
@export var gravity = 10
@export var jumpForce = 450
@export var theAcc = 0
var prevDir = 0
var horizontalDirection = -2

var wallJumpPushBack = 100

func _physics_process(delta):
	
	if(!is_on_floor()):
		
		velocity.y += gravity
		
		if velocity.y > 999:
			velocity.y = 999
		
			
	if(Input.is_action_just_pressed("jump") && is_on_floor()):
		velocity.y = -jumpForce
		
	if(is_on_wall() and Input.is_action_just_pressed("move_right")):
		velocity.y = -jumpForce
		velocity.x = -wallJumpPushBack
		
	if(is_on_wall() and Input.is_action_just_pressed("move_left")):
		velocity.y = -jumpForce
		velocity.x = wallJumpPushBack
		
	
	if(prevDir == horizontalDirection && horizontalDirection != 0):
		theAcc += 1
		if(theAcc < 50):
			speed = 300
		elif(theAcc < 150):
			speed = 600
		else:
			speed = 900
		velocity.x = speed * horizontalDirection
	else:
		theAcc = 1
		speed = 300
		velocity.x = speed * horizontalDirection
		
	prevDir = horizontalDirection
	
	horizontalDirection = Input.get_axis("move_left", "move_right")
	
	# velocity.x = speed * horizontalDirection
	set_velocity(velocity)
	move_and_slide()
	
	print("Direction: ", horizontalDirection)
	print("Acceleration: ", theAcc)
	print("Speed: ", speed)
