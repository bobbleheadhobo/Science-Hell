"""
player.gd - Handles the player in Ivan's level like physics, animations, damage by enemies, etc.
"""
class_name Player
extends CharacterBody2D

var enemy_in_range = false
var enemy_cooldown = true
var health = 100
var alive = true

var attack = false

@export var speed : float = 175.0
@export var jump_velocity : float = -300.0
@export var level_start_pos : Node2D 

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var way : bool = false

var can_control : bool = true

# Loads the player with the selected character
func _ready():
	$Sprite2D.texture = Characters.current_sprite

# Processes the movements, animations, and physics of the player
func _physics_process(delta):
	if not can_control: return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("shoot") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	enemy_attack()
	
	# Player dead
	if health <= 0:
		alive = false
		health = 0
		print("Player died")
		self.queue_free()
		
	update_animation()

# Updates animation based on player's direction
func update_animation():
	if not animation_locked:
		if direction.x != 0:
			if direction.x > 0:
				$AnimationPlayer.play("walk_right")
				way = false
	
			elif direction.x < 0:
				$AnimationPlayer.play("walk_left")
				way = true
		
		else:
			if way:
				$AnimationPlayer.play("idle_left")
			else:
				$AnimationPlayer.play("idle_right")

# Function when player falls into danger
func handle_danger() -> void:
	print("Player died")
	visible = false
	can_control = false
	
	await get_tree().create_timer(1).timeout
	Health.update_health(Health.current_health - 1)
	reset_play()

# Resets player global position
func reset_play() -> void:
	global_position = Vector2.ZERO
	visible = true 
	can_control = true

func player():
	pass

func bullet():
	pass

# Player's hitbox entered by enemy sprite
func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		print("player hitbox entered")
		enemy_in_range = true

# Player's hitbox exited by enemy sprite
func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_range = false

# Function to manage when player is attacked by enemy
func enemy_attack():
	if enemy_in_range and enemy_cooldown:
		Health.update_health(Health.current_health - 1)
	
		if Health.current_health <= 0:
			print("DEAD!")
			
		enemy_cooldown = false
		$attack_cooldown.start()

# Function to manages enemy's attack cooldown
func _on_attack_cooldown_timeout():
	enemy_cooldown = true
