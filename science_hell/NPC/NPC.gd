extends CharacterBody2D

const SPEED = 50
const PAUSE_TIME_MIN = 1.0
const PAUSE_TIME_MAX = 3.0

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

var pause_timer = null
var walk_timer = null

func _ready():
	$Sprite2D.texture = Characters.set_character("reynolds")
	pause_timer = get_tree().create_timer(randf_range(PAUSE_TIME_MIN, PAUSE_TIME_MAX))
	pause_timer.connect("timeout", _on_pause_timer_timeout)
	walk_timer = get_tree().create_timer(randf_range(1.0, 3.0))
	walk_timer.connect("timeout", _on_walk_timer_timeout)

func _physics_process(delta):
	move_and_slide()
	animate()

func move(direction):
	velocity = direction * SPEED
	blend_position = direction.normalized()

func _on_pause_timer_timeout():
	state = IDLE
	velocity = Vector2.ZERO
	blend_position = Vector2.ZERO
	pause_timer = get_tree().create_timer(randf_range(PAUSE_TIME_MIN, PAUSE_TIME_MAX))
	pause_timer.connect("timeout", _on_pause_timer_timeout)

func _on_walk_timer_timeout():
	state = WALK
	var random_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	move(random_direction)
	walk_timer = get_tree().create_timer(randf_range(1.0, 3.0))
	walk_timer.connect("timeout", _on_walk_timer_timeout)

func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state], blend_position)
