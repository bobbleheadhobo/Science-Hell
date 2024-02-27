extends CharacterBody2D

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600 # move in the direction at 600 px per second
	move_and_slide()
	
	# press space to shoot
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	#if velocity.length() > 0.0:
		#$HappyBoo.play_walk_animation() #is the same as get_node()
	#else:
		#$HappyBoo.play_idle_animation()


func shoot():
	var gun = $AR_15
	if gun:
		gun.shoot()
