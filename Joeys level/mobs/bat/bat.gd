extends CharacterBody2D

@onready var player = get_node("/root/Debug_or_die/lvl5_Player")
var health = 3
var mob_id = null

signal mob_killed

func _ready():
	$AnimationPlayer.play("fly")
	mob_id = generate_mob_id()

func _physics_process(delta):
	# move toward player
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()
	flip_sprite(direction)

func flip_sprite(direction):
	# Flip the sprite based on the direction of movement
		if direction.x < 0:
			$Sprite2D.flip_h = true
		elif direction.x > 0:
			$Sprite2D.flip_h = false


func take_damage():
	health -= 1
	print("bat hurt")

	if health <= 0:
		emit_signal("mob_killed")
		queue_free()
		return # Exit function after queue_free
		
func generate_mob_id():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	mob_id = rng.randi()
	return mob_id

func get_mob_id():
	return mob_id
