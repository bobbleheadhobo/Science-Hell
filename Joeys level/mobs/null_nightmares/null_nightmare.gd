extends CharacterBody2D

@onready var player = get_node("/root/Debug_or_die/player")  # Assuming player node path
var health = 3
var invincible
var rng = RandomNumberGenerator.new()

func _ready():
	$null_animation.play_walking_animation(1)  # Assuming animation player node exists

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()
	
func set_invincibility(value : bool):
	invincible = value

func take_damage():
	if invincible:
		return
	
	health -= 1
	print("Ouch!")

	if health <= 0:
		$null_animation.play_death_animation(3)
		#await get_tree().create_timer(0.4).timeout
		queue_free()
		
		return  # Exit function after queue_free
	else:
		$null_animation.play_vanish_animation(3.0)  # Assuming vanish animation exists		
		#await get_tree().create_timer(0.4).timeout
		teleport_closer_to_player()

func teleport_closer_to_player():
	var teleport_distance = rng.randf_range(100, 500)  # Random distance between 100 and 500 pixels
	var direction_to_player = global_position.direction_to(player.global_position)
	var new_position = player.global_position + direction_to_player * teleport_distance
	global_position = new_position  # Update mob's position
	$null_animation.play_appear_animation(3.0)  # Add your appear animation play call here
	await get_tree().create_timer(0.4).timeout	
	$null_animation.play_walking_animation(1.0)



