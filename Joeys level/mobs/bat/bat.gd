extends CharacterBody2D

@onready var player = get_node("/root/Debug_or_die/lvl5_Player")
@onready var shooting_range = 300.0  # Adjust this value to set the shooting range

func _ready():
	$AnimationPlayer.play("fly")

func _physics_process(delta):
	var distance_to_player = global_position.distance_to(player.global_position)
	
	if distance_to_player > shooting_range:
		# Move towards the player if outside the shooting range
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 300.0
		move_and_slide()
		flip_sprite(direction)
	else:
		# Stop moving and shoot if within the shooting range
		velocity = Vector2.ZERO
		shoot()

func shoot():
	# Add your shooting logic here
	#print("Duck mob is shooting!")
	#Example: Instantiate a projectile and set its direction towards the player
	var projectile = preload("res://Joeys level/weapons/ar/ar_bullet.tscn").instantiate()
	add_child(projectile)
	projectile.global_position = global_position
	projectile.direction = global_position.direction_to(player.global_position)

func flip_sprite(direction):
	# Flip the sprite based on the direction of movement
		if direction.x < 0:
			$Sprite2D.flip_h = true
		elif direction.x > 0:
			$Sprite2D.flip_h = false
