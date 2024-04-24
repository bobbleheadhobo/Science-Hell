class_name Player
extends CharacterBody2D

enum {IDLE, WALK}
var state = IDLE

@onready var animationTree = %AnimationTree
@onready var state_machine = animationTree["parameters/playback"]

@export var speed : float = 200.0
@export var jump_velocity : float = -250.0
@export var level_start_pos : Node2D 
@onready var GUN = $Excaliboard

var blend_position : Vector2 = Vector2.ZERO
var blend_pos_paths = [
	"parameters/idle/idle_bsd2/blend_position",
	"parameters/walk/walk_bsd2/blend_position"
]

var animTree_state_keys = [
	"idle",
	'walk'
]

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO

var can_control : bool = true

func _ready():
	print(Characters.current_sprite)
	$Sprite2D.texture = Characters.current_sprite

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
	animate()
	update_facing_direction()

func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state], blend_position)
			
func update_facing_direction():
	if direction.x > 0:
		GUN.right()
		#animated_sprite.flip_h = false
	
	elif direction.x < 0:
		GUN.left()
		#animated_sprite.flip_h = true
		
		
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


func _on_boss_room_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("here")
	print(area)
	pass # Replace with function body.
