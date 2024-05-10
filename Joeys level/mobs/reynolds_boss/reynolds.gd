extends CharacterBody2D

const SPEED = 500
const SHOOTING_RANGE = 500.0
const CLOSEST_DISTANCE = 100.0
const PUSH_FORCE = 1500.0
@onready var health = $ProgressBar.max_value

var mobs_in_area = []

var is_hurt = false
signal level_over

var knockback_strength = 500.0
var knockback = Vector2.ZERO


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
	$Sprite2D.texture = Characters.set_professor("reynolds")
	$ProgressBar.value = health
	

func _physics_process(delta):
	move(delta)
	animate()
	move_and_slide()
	
	for mob in mobs_in_area:
		var push_direction = (mob.global_position - global_position).normalized()
		mob.knockback = push_direction * PUSH_FORCE

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
	var rey_bullet = rey_bullet_scene.instantiate()
	add_child(rey_bullet)
	rey_bullet.global_position = global_position
	var bullet_direction = global_position.direction_to(player.global_position)
	rey_bullet.set_direction(bullet_direction)
	rey_bullet.play_shoot_animation(1.7)
	
	
func take_damage(damage_location):
	health -= 1
	$ProgressBar.value = health
	
	if health <= 0:
		var psu = load("res://Joeys level/level/powersupply.tscn").instantiate()
		psu.global_position = global_position  # Set the position of the power supply
		get_parent().add_child(psu)  # Add the power supply to the parent node
		emit_signal("level_over")
		call_deferred("queue_free")
		return # Exit function after queue_free
	
	var direction = damage_location.direction_to(global_position)
	knockback = direction * knockback_strength

func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state], blend_position)


func _on_area_2d_body_entered(body):
	if body.is_in_group("mobs") and not body in mobs_in_area:
		mobs_in_area.append(body)


func _on_area_2d_body_exited(body):
	if body.is_in_group("mobs") and body in mobs_in_area:
		mobs_in_area.erase(body)
