extends CharacterBody2D

@onready var player = get_node("/root/Debug_or_die/player")

var health = 3


func _ready():
	$null_animation.play_walking_animation()

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()
	

func take_damage():
	health -= 1
	print("Ouch!")
	
	if health <= 0:
		$null_animation.play_vanish_animation()
		await get_tree().create_timer(1.1).timeout # wait for 1.1 seconds
		queue_free()
