extends CharacterBody2D

@export var speed = 25
@export var gravity = 10

@onready var PlayerNode = get_node("Player")
# @export var jumpForce = 450
var prevDir = 0
var horizontalDirection = -1

func _physics_process(delta):
	
	if(!is_on_floor()):
		
		velocity.y += gravity
		
		if velocity.y > 999:
			velocity.y = 999
			
	
	velocity.x = speed * horizontalDirection
	
	set_velocity(velocity)
	
	#if(checkDistance() < 5):
	move_and_slide()

'''
func checkDistance():
	var theX = PlayerNode.position.x
	var theY = PlayerNode.position.y
	
	var distance = sqrt(theX * theX + theY * theY)
	
	print(distance)
	
	return distance
	
'''

func _on_hitbox_body_entered(body):
	if(body.is_in_group("Player")):
		queue_free()


func _on_rush_box_body_entered(body):
	if(body.is_in_group("Player") && Input.is_action_pressed("sprint")):
		queue_free()
