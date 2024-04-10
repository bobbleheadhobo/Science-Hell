extends CharacterBody2D

@export var speed = 100
@export var gravity = 10
# @export var jumpForce = 450
var prevDir = 0
var horizontalDirection = 1

func _physics_process(delta):
	
	if(!is_on_floor()):
		
		velocity.y += gravity
		
		if velocity.y > 999:
			velocity.y = 999
			
	velocity.x = speed * horizontalDirection
			
	set_velocity(velocity)
	move_and_slide()
