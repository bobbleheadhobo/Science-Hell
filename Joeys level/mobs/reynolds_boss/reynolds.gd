extends CharacterBody2D

const SPEED = 400
const SHOOTING_RANGE = 500.0
const CLOSEST_DISTANCE = 100.0


enum {IDLE, WALK}
var state = IDLE

@onready var animationTree = %AnimationTree
@onready var state_machine = animationTree["parameters/playback"]
@onready var player = get_node("/root/Debug_or_die/lvl5_Player")

var blend_position : Vector2 = Vector2.ZERO
var blend_pos_paths = [
	"parameters/idle/idle_bsd2/blend_position",
	"parameters/walk/walk_bsd2/blend_position"
]
var animTree_state_keys = [
	"idle",
	'walk'
]

var rey_bullet_scene = preload("res://Joeys level/mobs/reynolds_boss/reynolds_bullets.tscn")
var can_shoot = true

func _ready():
	$Sprite2D.texture = Characters.set_character("reynolds")

func _physics_process(delta):
	move(delta)
	animate()
	move_and_slide()

func move(delta):
	var distance_to_player = global_position.distance_to(player.global_position)
	var direction = global_position.direction_to(player.global_position)
	
	if distance_to_player > CLOSEST_DISTANCE:
		state = WALK
		velocity = direction * SPEED
		blend_position = direction.normalized()
	else:
		state = IDLE
		velocity = Vector2.ZERO
		blend_position = Vector2.ZERO
		
	if distance_to_player < SHOOTING_RANGE:
		if can_shoot:
			shoot()
			can_shoot = false
			await get_tree().create_timer(1.0).timeout
			can_shoot = true

func shoot():
	print("shoot")
	var rey_bullet = rey_bullet_scene.instantiate()
	add_child(rey_bullet)
	rey_bullet.global_position = global_position
	var bullet_direction = global_position.direction_to(player.global_position)
	rey_bullet.set_direction(bullet_direction)
	rey_bullet.play_shoot_animation(1.7)

func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state], blend_position)
