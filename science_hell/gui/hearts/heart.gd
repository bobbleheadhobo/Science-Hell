"""
heart.gd - Handles the heart sprite and its state/animations
"""
extends Panel

@onready var heart = $Sprite2D

enum Heart_State {FULL, HALF, EMPTY}
var current_state = Heart_State.FULL

# Returns state of the heart
func get_state():
	return current_state

# Updates the state of the heart
func update_state(state : Heart_State):
	if state == Heart_State.FULL:
		heart.frame = 0
	elif state == Heart_State.HALF:
		heart.frame = 5
	elif state == Heart_State.EMPTY:
		heart.frame = 8
	else:
		print("UHHH this is awkward")
		
	current_state = state

#ANIMATIONS
func play_animation(name: String, speed = 1):
	if $AnimationPlayer.current_animation != name:
		$AnimationPlayer.play(name, 1, speed)
	
func stop_animation(name: String):
	if $AnimationPlayer.current_animation == name:
		$AnimationPlayer.stop()
		
func stop_all_animations():
	$AnimationPlayer.stop()

