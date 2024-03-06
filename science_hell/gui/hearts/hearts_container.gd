extends HBoxContainer

@onready var HeartGUI = preload("res://science_hell/gui/hearts/heart.tscn")
var max_health = 10
var shake = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_max_hearts(max_hearts : int):
	# divided by two because theres half hearts
	for i in range(max_hearts/2):
		var heart = HeartGUI.instantiate()
		add_child(heart)
		
# Updates the health display based on the new health value.
# @param new_health The new health value to set.
func update_health(new_health : int):
	# Clamp the new health value to ensure it's within the valid range (0 to max_health).
	var heart_points = clamp(new_health, 0, max_health)
	
	# if low health set hearts to shake
	if heart_points <= 2:
		shake = true
	else:
		shake = false

	# Retrieve all heart icon nodes as children of this node.
	var hearts = get_children()
	
	# Iterate over each heart icon node to update its state based on remaining health points.
	for heart in hearts:
		# get current state of the heart
		var current_heart_state = heart.get_state()
		
		# if low health shake hearts
		if shake:
			heart.stop_all_animations()
			heart.play_animation("shake")
		else:
			heart.stop_animation("shake")
		
		# If there are enough points for at least one full heart, update this heart to full
		if heart_points >= 2:
			if current_heart_state != heart.Heart_State.FULL:
				heart.update_state(heart.Heart_State.FULL)
				heart.stop_all_animations() 
				heart.play_animation("grow")
				#heart.play_animation("jump")
				#heart.play_animation("spin", 1.4)
				
			heart_points -= 2  # Deduct the points for a full heart.
		
		# If there is exactly one point left, update this heart to half
		elif heart_points == 1:
			if current_heart_state != heart.Heart_State.HALF:
				heart.update_state(heart.Heart_State.HALF)
				
				# if going from empty to half play animation
				if current_heart_state == heart.Heart_State.EMPTY:
					heart.stop_all_animations()
					heart.play_animation("grow")
					#heart.play_animation("jump")
					#heart.play_animation("spin", 1.4)
					
			heart_points -= 1  # Deduct the point for a half heart.
		
		# If there are no points left, update this heart to empty
		else:
			if current_heart_state != heart.Heart_State.EMPTY:
				heart.update_state(heart.Heart_State.EMPTY)
				
