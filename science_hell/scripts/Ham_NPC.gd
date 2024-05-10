"""
Ham_NPC.gd - Handles the Dr. Hamilton NPC (movements/animations) and his chatbox
"""
extends CharacterBody2D

var current_state = IDLE 
const speed = 30

var dir = Vector2.RIGHT

var is_roaming = false
var is_chatting = false

var player_in_area = false

enum {
	IDLE,
	NEW_DIR,
	MOVE
} 

func _ready():
	randomize()

# Processes the NPC's state in the game
func _process(delta):
	if player_in_area:
		if Input.is_action_just_pressed("e"):
			run_dialogue("Hamgiving")
			
	if current_state == 0 or current_state == 1:
		$AnimatedSprite2D.play("front_idle")
		
	elif current_state == 2 and !is_chatting:
		if dir.x == -1:
			$AnimatedSprite2D.play("left_walk")
			
		if dir.x == 1:
			$AnimatedSprite2D.play("right_walk")
			
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT,Vector2.LEFT])	
			MOVE:
				move(delta)

# Runs dialogues
func run_dialogue(dialogue_string):
	is_chatting = true
	is_roaming = false
	Dialogic.start(dialogue_string)

func choose(array):
	array.shuffle()
	return array.front()

# Move function
func move(delta):
	if !is_chatting:
		position = dir * speed * delta

func _on_timer_timeout():
	$Timer.wait_time = choose([0.5,1,1.5])
	current_state = choose([IDLE,NEW_DIR,MOVE])

# Chat area entered, so player can chat
func _on_chat_det_body_entered(body):
	print(body.has_method("player"))
	if body.has_method("player"):
		player_in_area = true

# Chat area exited, so player cannot chat
func _on_chat_det_body_exited(body):
	if body.has_method("player"):
		player_in_area = false 
