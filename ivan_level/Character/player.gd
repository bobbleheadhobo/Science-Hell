class_name Player
extends CharacterBody2D

var enemy_in_range = false
var enemy_cooldown = true
var health = 100
var alive = true

var attack = false

@export var speed : float = 200.0
@export var jump_velocity : float = -250.0
@export var level_start_pos : Node2D 
@onready var GUN = $Excaliboard

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var way : bool = false

var can_control : bool = true

func _ready():
	print(Characters.current_sprite)
	$Sprite2D.texture = Characters.current_sprite

func _physics_process(delta):
	if not can_control: return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("shoot") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	enemy_attack()
	
	if health <= 0:
		alive = false
		health = 0
		print("Player died")
		self.queue_free()
		
	shoot()
	update_animation()
	update_facing_direction()

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

func update_facing_direction():
	if direction.x > 0:
		GUN.right()
	
	elif direction.x < 0:
		GUN.left()

func shoot():
	if Input.is_action_just_pressed("jump"):
		if GUN:
			GUN.shoot()
		

func handle_danger() -> void:
	print("Player died")
	visible = false
	can_control = false
	
	await get_tree().create_timer(1).timeout
	reset_play()

func reset_play() -> void:
	global_position = Vector2.ZERO
	visible = true 
	can_control = true

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_range = false

func enemy_attack():
	if enemy_in_range and enemy_cooldown:
		health = health - 20
		enemy_cooldown = false
		$attack_cooldown.start()
		print(health)

func _on_attack_cooldown_timeout():
	enemy_cooldown = true
