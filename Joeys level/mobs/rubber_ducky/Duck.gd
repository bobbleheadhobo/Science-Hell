extends CharacterBody2D

@onready var player = get_node("/root/Debug_or_die/lvl5_Player")
@onready var shooting_range = 300.0 # Adjust this value to set the shooting range

var duck_bullet_scene = preload("res://Joeys level/mobs/rubber_ducky/duck_bullets.tscn")
var health = 3
var can_shoot = true

signal mob_killed

func _ready():
	$AnimationPlayer.play("idle")
	shoot()

func _physics_process(delta):
	var distance_to_player = global_position.distance_to(player.global_position)
	
	if distance_to_player > shooting_range:
		# Play the walk animation
		if not $AnimationPlayer.current_animation == "walk_bounce":
			$AnimationPlayer.play("walk_bounce")
		
		# Move towards the player if outside the shooting range
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 300.0
		move_and_slide()
		flip_sprite(direction)
		
	else:
		# Play the idle animation
		if not $AnimationPlayer.current_animation == "idle":
			$AnimationPlayer.play("idle")
		
		# Stop moving when within the shooting range
		velocity = Vector2.ZERO
		
		# only shoot every 3 seconds
		if can_shoot:
			shoot()
			can_shoot = false
			await get_tree().create_timer(3.0).timeout
			can_shoot = true

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

func take_damage():
	health -= 1
	if health <= 0:
		emit_signal("mob_killed")
		queue_free()
		return # Exit function after queue_free
