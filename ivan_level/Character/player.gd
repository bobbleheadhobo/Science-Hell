class_name Player
extends CharacterBody2D


@export var speed : float = 200.0
@export var jump_velocity : float = -250.0
@export var level_start_pos : Node2D 
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var GUN = $AR_15

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO

var can_control : bool = true

func _physics_process(delta):
	if not can_control: return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("shoot") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	shoot()
	update_animation()
	update_facing_direction()

func update_animation():
	if not animation_locked:
		if direction.x != 0:
			animated_sprite.play("run")
		
		else:
			animated_sprite.play("idle")
			
func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	
	elif direction.x < 0:
		animated_sprite.flip_h = true
		
		
func shoot():
	if Input.is_action_just_pressed("jump"):
		if GUN:
			GUN.shoot()
		

func handle_danger() -> void:
	print("Player died")
	visible = false
	can_control = false
	
	await get_tree().create_timer(1).timeout
	reset_play()

func reset_play() -> void:
	global_position = Vector2.ZERO
	visible = true 
	can_control = true

