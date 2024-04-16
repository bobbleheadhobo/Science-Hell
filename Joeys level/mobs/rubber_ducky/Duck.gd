extends CharacterBody2D

@onready var player = get_node("/root/Debug_or_die/lvl5_Player")
@onready var shooting_range = 300.0 # Adjust this value to set the shooting range

var duck_bullet_scene = preload("res://Joeys level/mobs/rubber_ducky/duck_bullets.tscn")
var health = 3
var can_shoot = true
var mob_id = null
var is_hurt = false

var knockback_strength = 500.0
var knockback = Vector2.ZERO

signal mob_killed

func _ready():
	play_animation("idle")
	shoot()
	mob_id = generate_mob_id()

func _physics_process(delta):
	if not is_hurt:
		var distance_to_player = global_position.distance_to(player.global_position)
		
		if distance_to_player > shooting_range:
			# Play the walk animation
			play_animation("walk")
			
			# Move towards the player if outside the shooting range
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * 300.0 + knockback
			move_and_slide()
			flip_sprite(direction)
			
		else:
			velocity = knockback
			# Play the idle animation
			play_animation("idle")
			
			# Stop moving when within the shooting range
			#velocity = Vector2.ZERO
			
			# only shoot every 3 seconds
			if can_shoot:
				shoot()
				can_shoot = false
				await get_tree().create_timer(3.0).timeout
				can_shoot = true
				
	move_and_slide()
	knockback = lerp(knockback, Vector2.ZERO, 0.1)

func shoot():
	var duck_bullet = duck_bullet_scene.instantiate()
	add_child(duck_bullet)
	duck_bullet.global_position = global_position
	var bullet_direction = global_position.direction_to(player.global_position)
	duck_bullet.set_direction(bullet_direction)
	duck_bullet.play_shoot_animation(0.8)

func flip_sprite(direction):
	# Flip the sprite based on the direction of movement
	if direction.x < 0:
		$Sprite2D.flip_h = true
	elif direction.x > 0:
		$Sprite2D.flip_h = false

func take_damage(damage_location):
	if health <= 0:
		emit_signal("mob_killed")
		queue_free()
		return # Exit function after queue_free
		
	health -= 1
	print("duck hurt")
	is_hurt = true
	$AnimationPlayer.stop()
	var hurt_animation_length = $AnimationPlayer.get_animation("hurt").length
	play_animation("hurt")
	await get_tree().create_timer(hurt_animation_length).timeout
	is_hurt = false
	
	var direction = damage_location.direction_to(global_position)
	knockback = direction * knockback_strength
	
		
func generate_mob_id():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	mob_id = rng.randi()
	return mob_id

func get_mob_id():
	return mob_id


func play_animation(name: String):
	if not $AnimationPlayer.current_animation == name:
		$AnimationPlayer.play(name)
	
