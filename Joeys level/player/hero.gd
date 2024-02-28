extends CharacterBody2D

signal health_empty

var health = 100.0
const DAMAGE_RATE = 10.0

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600 # move in the direction at 600 px per second
	move_and_slide()
	
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
	
	#if velocity.length() > 0.0:
		#$HappyBoo.play_walk_animation() #is the same as get_node()
	#else:
		#$HappyBoo.play_idle_animation()


func shoot():
	var gun = $AR_15
	if gun:
		gun.shoot()
