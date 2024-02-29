extends CharacterBody2D

signal health_empty

var health = 100.0
const DAMAGE_RATE = 10.0
const ACCELERATION = 800
const FRICTION = 2000
const MAX_SPEED = 200

enum {IDLE, WALK}
var state = IDLE

@onready var animationTree = %AnimationTree
@onready var state_machine = animationTree["parameters/playback"]

var blend_position : Vector2 = Vector2.ZERO
var blend_pos_paths = [
	"parameters/idle/idle_bsd2/blend_position",
	"parameters/walk/walk_bsd2/blend_position"
]

var animTree_state_keys = [
	"idle",
	'walk'
]

func _physics_process(delta):
	#var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#velocity = direction * 600 # move in the direction at 600 px per second
	#move_and_slide()
	animate()
	move(delta)
	
	# press space to shoot
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
	
	var overlapping_mobs = %hurtbox.get_overlapping_bodies()
	
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%HealthBar.value = health
		if health <= 0.0:
			print("DEAD!")
			health_empty.emit()
	
	#if velocity.length() > 0.0:
		#$HappyBoo.play_walk_animation() #is the same as get_node()
	#else:
		#$HappyBoo.play_idle_animation()


func shoot():
	var gun = $AR_15
	if gun:
		gun.shoot()
		
		
		

func move(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up" , "move_down")
	if direction == Vector2.ZERO:
		state = IDLE
		#apply_friction(FRICTION * delta)
	else:
		state = WALK
		#apply_movement(direction * ACCELERATION * delta)
		blend_position = direction
		
	
	velocity = direction * MAX_SPEED
	print("velocity", velocity, "direction", direction)
	move_and_slide()
		
func apply_movement(amount) -> void:
	velocity += amount
	velocity = velocity.limit_length(MAX_SPEED)
	
		
func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO
		

func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state], blend_position)
