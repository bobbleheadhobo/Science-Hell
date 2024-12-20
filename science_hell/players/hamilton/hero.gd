# code that allows you to control the player in the sciecne hall map

class_name Hero
extends CharacterBody2D

const SPEED = 200
var initial_position = null

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

# Dictates which character was selected and where the player spawns in the main map
func _ready():
	$Sprite2D.texture = Characters.current_sprite
	if SceneManager.player_position != null:
		position = SceneManager.player_position
	
	SceneManager.player_position = position

# Processes the movements and animations of the player
func _physics_process(delta):
	move_and_animate(delta)
	
	# log position if player is not in doorway
	if SceneManager.player_position != null and not is_inside_doorway():
		SceneManager.player_position = position

# Handles the input from keyboard to control the player
func move_and_animate(delta):
	# get input from keyboard (WASD)
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up" , "ui_down")
	
	if direction == Vector2.ZERO:
		state = IDLE
	else:
		state = WALK
		blend_position = direction
	
	# calculate the velocity to move the player at
	velocity = direction * SPEED
	
	animate()
	move_and_slide()
		

# Animates the sprite
func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state], blend_position)
	
func player():
	pass

# Doorway function
func is_inside_doorway():
	for area in $DoorwayDetector.get_overlapping_areas():
		if area.is_in_group("doorways"):
			return true
			
	return false
