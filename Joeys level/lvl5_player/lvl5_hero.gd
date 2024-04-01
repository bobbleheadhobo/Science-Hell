extends CharacterBody2D

signal health_empty

const SPEED = 600


var mobs_killed = 0

enum {IDLE, WALK}
var state = IDLE

@onready var animationTree = %AnimationTree
@onready var state_machine = animationTree["parameters/playback"]
@onready var GUN = $AR_15


var blend_position : Vector2 = Vector2.ZERO
var blend_pos_paths = [
	"parameters/idle/idle_bsd2/blend_position",
	"parameters/walk/walk_bsd2/blend_position"
]

var animTree_state_keys = [
	"idle",
	'walk'
]

var knockback_duration = 0.2  # Duration of the knockback effect in seconds
var knockback_timer = 0.0
var knockback_direction = Vector2.ZERO



func _physics_process(delta):
	move(delta)
	shoot()
	handle_mob_collision(delta)
	move_and_slide()


func shoot():
	if Input.is_action_just_pressed("shoot"):
		if GUN:
			GUN.shoot()
		

func move(delta):
	# get input from keyboard (WASD)
	var direction = Input.get_vector("move_left", "move_right", "move_up" , "move_down")
	
	if direction == Vector2.ZERO:
		state = IDLE
	else:
		state = WALK
		blend_position = direction
	
	# calculate the velocity to move the player at
	velocity = direction * SPEED
	
	animate()
	move_and_slide()
		

func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state], blend_position)


func handle_mob_collision(delta):
	var overlapping_mobs = %hurtbox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		for mob in overlapping_mobs:
			knockback_direction = (global_position - mob.global_position).normalized()
			knockback_timer = knockback_duration
		update_health()
	
	if knockback_timer > 0:
		var knockback_force = 5000 # Adjust this value to control the knockback strength
		var knockback_velocity = knockback_direction * knockback_force
		var interpolation_factor = knockback_timer / knockback_duration
		velocity += knockback_velocity * interpolation_factor
		knockback_timer -= delta
		
func update_health():
	Health.update_health(Health.current_health - 0.1)
	print(Health.current_health)
	if Health.current_health <= 0:
		print("DEAD!")
		health_empty.emit()
