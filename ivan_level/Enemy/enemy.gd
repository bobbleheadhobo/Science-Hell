extends CharacterBody2D

var speed = 25
var player_chase = false
var player = null

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if player_chase:
		position += (player.position - position) / speed
		# Add the gravity.
		velocity.y += gravity * delta

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
