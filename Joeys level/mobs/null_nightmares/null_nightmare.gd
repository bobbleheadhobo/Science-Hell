extends CharacterBody2D

@onready var player = get_node("/root/Debug_or_die/player")


func _ready():
	$null_animation.play_walking_animation()

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()
