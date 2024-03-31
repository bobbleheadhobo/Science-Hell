extends Panel

@onready var heart = $Sprite2D

enum Heart_State {FULL, HALF, EMPTY}
var current_state = Heart_State.FULL

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func get_state():
	return current_state


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
	
	
func play_animation(name: String, speed = 1):
	if $AnimationPlayer.current_animation != name:
		$AnimationPlayer.play(name, 1, speed)
	
func stop_animation(name: String):
	if $AnimationPlayer.current_animation == name:
		$AnimationPlayer.stop()
		
func stop_all_animations():
	$AnimationPlayer.stop()

