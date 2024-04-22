extends CharacterBody2D

signal healthChanged

@export var speed = 100
@export var theAcc = 0
@export var maxHealth = 5
@export var knockbackPower = 300

@onready var currentHealth: int = maxHealth
@onready var animations = $AnimationPlayer
# @onready var effects = something
@onready var hurtbox = $HurtBox
# @onready var hurttimer = something
@onready var camera = $PlayerView
@onready var sprite = $PlayerSprite

var isHurt: bool = false
var prevDir = 0
var horizontalDirection = 1
var wallJumpPushBack = 100
var gravity = 10
var jumpForce = 185
var stompForce = 400

# function used to set up camera properly
func _ready():
	camera.zoom.x = 8
	camera.zoom.y = 8
	
	# add Player to colliding list
	add_to_group("Player")

func _physics_process(delta):
	
	handleSprite(horizontalDirection)
	
	# if statement that handles gravity
	# while player is not on the ground
	if(!is_on_floor()):
		
		velocity.y += gravity
		
		# verify player speed is capped
		# for gravity
		if velocity.y > 999:
			velocity.y = 999
		
	# handle jump input
	if(Input.is_action_just_pressed("jump") && is_on_floor()):
		velocity.y = -jumpForce
		
	# handle wall jump input to the right
	if(is_on_wall() and Input.is_action_just_pressed("move_right")):
		velocity.y = -jumpForce
		velocity.x = -wallJumpPushBack
	
	# handle wall jump input to the left
	if(is_on_wall() and Input.is_action_just_pressed("move_left")):
		velocity.y = -jumpForce
		velocity.x = wallJumpPushBack
		
	# if statement used to increase velocity if player
	# holds the same direction for a while
	if(prevDir == horizontalDirection && horizontalDirection != 0):
		
		theAcc += 1
		if(theAcc < 50):
			speed = 100
		elif(theAcc < 150):
			speed = 200
		else:
			speed = 350
		velocity.x = speed * horizontalDirection
	else:
		theAcc = 1
		speed = 100
		velocity.x = speed * horizontalDirection
	
	# update previous direction
	prevDir = horizontalDirection
	
	# update current direction
	horizontalDirection = Input.get_axis("move_left", "move_right")
	
	# statements used to move player
	# at set velocity
	set_velocity(velocity)
	move_and_slide()
	
	print("Direction: ", horizontalDirection)
	print("Acceleration: ", theAcc)
	print("Speed: ", speed)

func handleSprite(currDirection):
	
	var textureRight = preload("res://Level4/Assets/characterSprites/jonathan/jonathanIdleRight.png")
	var textureLeft = preload("res://Level4/Assets/characterSprites/jonathan/jonathanIdleLeft.png")
	
	if(currDirection == -1):
		sprite.set_texture(textureLeft)
	else:
		sprite.set_texture(textureRight)

# tried to implement bouncing off of enemies
func _on_signal_hurt_box_body_entered(body):
	
	if(body == $basicVirus && Input.is_action_just_pressed("jump")):
		velocity.y = -jumpForce
	elif(body == $basicVirus):
		velocity.y = -stompForce
	else:
		pass
