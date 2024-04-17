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
var last_mob_id = null

func _ready():
	$Sprite2D.texture = Characters.current_sprite

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
	
	## Flip the gun based on the direction of movement
	#if direction.x < 0:
		#GUN.flip_sprite(true)
	#elif direction.x > 0:
		#GUN.flip_sprite(false)
		

func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state], blend_position)


var last_hit_time = 0

func handle_mob_collision(delta):
	var overlapping_mobs = %hurtbox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		for mob in overlapping_mobs:
			if mob.has_method("get_mob_id"):
				var mob_id = mob.get_mob_id()
				var current_time = Time.get_ticks_msec() / 1000.0  # Get current time in seconds

				if mob_id == last_mob_id and current_time - last_hit_time <= 0.3:
					mob.queue_free()
					print("Killed buggy mob")
				else:
					last_mob_id = mob_id
					last_hit_time = current_time
					print(last_mob_id)

				knockback_direction = (global_position - mob.global_position).normalized()
				knockback_timer = knockback_duration
				take_damage()
	
	if knockback_timer > 0:
		var knockback_force = 5000 # Adjust this value to control the knockback strength
		var knockback_velocity = knockback_direction * knockback_force
		var interpolation_factor = knockback_timer / knockback_duration
		velocity += knockback_velocity * interpolation_factor
		knockback_timer -= delta
		
func take_damage():
	Health.update_health(Health.current_health - 1)
	if Health.current_health <= 0:
		print("DEAD!")
