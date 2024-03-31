extends CharacterBody2D

signal health_empty

var health = 100.0
const DAMAGE_RATE = 10.0
const SPEED = 600

var mobs_killed = 0

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


func shoot():
	var gun = $AR_15
	if gun:
		gun.shoot()
		
		
		
		

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
