extends CharacterBody2D

@onready var player = get_node("/root/Debug_or_die/lvl5_Player")

signal mob_killed

var health = 3
var invincible = false
var rng = RandomNumberGenerator.new()
var mob_id = null
var is_hurt = false


func _ready():
	$null_animation.play_walking_animation(1)
	mob_id = generate_mob_id()
	

func _physics_process(delta):
	if not invincible: #also means if not hurt
		$null_animation.play_walking_animation(1)	
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 300.0
		move_and_slide()
		flip_sprite(direction)

func take_damage(damage_location):
	if invincible:
		return

	health -= 1

	if health <= 0:
		$null_animation.play_death_animation(3)
		mob_killed.emit()
		queue_free()
		return # Exit function after queue_free
	else:
		invincible = true # Set invincibility to true  while animation
		$null_animation.play_vanish_animation(3.0)
		teleport_closer_to_player()
		await get_tree().create_timer(0.2).timeout # dont change
		invincible = false # Set invincibility back to false after the duration

func teleport_closer_to_player():
	var teleport_distance = rng.randf_range(100, 500) # Random distance between 100 and 500 pixels
	var direction_to_player = global_position.direction_to(player.global_position)
	var new_position = player.global_position + direction_to_player * teleport_distance
	global_position = new_position # Update mob's position
	$null_animation.play_appear_animation(3.0) 
	await get_tree().create_timer(0.4).timeout
	$null_animation.play_walking_animation(1.0)


func generate_mob_id():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	mob_id = rng.randi()
	return mob_id

func get_mob_id():
	return mob_id
	
func flip_sprite(direction):
	# Flip the sprite based on the direction of movement
		if direction.x > 0:
			$Sprite2D.flip_h = true
		elif direction.x < 0:
			$Sprite2D.flip_h = false
