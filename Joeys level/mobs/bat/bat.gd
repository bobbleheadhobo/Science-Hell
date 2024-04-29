extends CharacterBody2D

@onready var player = get_node("/root/Debug_or_die/lvl5_Player")
var health = 3
var mob_id = null
var is_hurt = false

var knockback_strength = 500.0
var knockback = Vector2.ZERO

signal mob_killed

func _ready():
	play_animation("fly")
	mob_id = generate_mob_id()
	add_to_group("mobs")

func _physics_process(delta):
	if not is_hurt:
		# move toward player
		play_animation("fly")
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 300.0 + knockback
		move_and_slide()
		flip_sprite(direction)
		knockback = lerp(knockback, Vector2.ZERO, 0.1)

func flip_sprite(direction):
	# Flip the sprite based on the direction of movement
		if direction.x < 0:
			$Sprite2D.flip_h = true
		elif direction.x > 0:
			$Sprite2D.flip_h = false


func take_damage(damage_location):
	health -= 1
	
	if health <= 0:
		emit_signal("mob_killed")
		queue_free()
		return # Exit function after queue_free
		
	is_hurt = true
	$AnimationPlayer.stop()
	var hurt_animation_length = $AnimationPlayer.get_animation("hurt").length
	play_animation("hurt")
	await get_tree().create_timer(hurt_animation_length - 0.05).timeout
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
