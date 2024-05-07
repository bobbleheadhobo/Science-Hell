extends CharacterBody2D

signal health_empty

const SPEED = 600
const INVINCIBILITY_DURATION = 1.0
var knockback_force = 3000


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
var invincibility_timer = 0.0

func _ready():
	$Sprite2D.texture = Characters.current_sprite
	if Rey.game_over:
		$ExitArrow.show()

func _physics_process(delta):
	move(delta)
	shoot()
	handle_mob_collision(delta)
	move_and_slide()
	flip_gun()
	update_invincibility(delta)


func shoot():
	if Input.is_action_just_pressed("shoot"):
		if GUN:
			GUN.shoot()
		

func move(delta):
	# get input from keyboard (WASD)
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction == Vector2.ZERO:
		state = IDLE
	else:
		state = WALK
		blend_position = direction
	
	# calculate the velocity to move the player at
	velocity = direction * SPEED
	
	if knockback_timer > 0:
		var interpolation_factor = knockback_timer / knockback_duration
		velocity = velocity.lerp(knockback_direction * knockback_force, 1 - interpolation_factor)
		knockback_timer -= delta
	
	animate()
	move_and_slide()
		

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
				var current_time = Time.get_ticks_msec() / 1000.0 # Get current time in seconds
				
				if mob_id == last_mob_id and current_time - last_hit_time <= 0.3:
					mob.queue_free()
					print("Killed buggy mob")
				else:
					last_mob_id = mob_id
					last_hit_time = current_time
					
					var mob_direction = (global_position - mob.global_position).normalized()
					take_damage(mob_direction)
		
func take_damage(damage_direction):
	if invincibility_timer > 0:
		return  # Player is invincible, ignore damage

	Health.update_health(Health.current_health - 1)
	knockback_direction = damage_direction
	knockback_timer = knockback_duration
	var knockback_velocity = knockback_direction * knockback_force
	velocity += knockback_velocity

	if Health.current_health <= 0:
		Rey.reset()
	else:
		invincibility_timer = INVINCIBILITY_DURATION
		
func update_invincibility(delta):
	if invincibility_timer > 0:
		invincibility_timer -= delta
		if invincibility_timer <= 0:
			invincibility_timer = 0.0

func player():
	pass
	
func show_arrow():
	$ExitArrow.show()
	$ExitArrow/AnimationPlayer.play("point")


func flip_gun():
	if blend_position.x < 0:
		GUN.flip_sprite(true)
	elif blend_position.x > 0:
		GUN.flip_sprite(false)
