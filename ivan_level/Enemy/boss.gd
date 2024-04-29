extends CharacterBody2D

var speed = 50
var player_chase = false
var player = null

var health = 1000
var player_inattack_zone = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if player_chase:
		position += (player.position - position) / speed
		# Add the gravity.
		velocity.y += gravity * delta

func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		print("Boss Detection entered")
		player = body
		player_chase = true

func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		print("Boss Detection exited")
		player = null
		player_chase = false

func enemy():
	pass

func deal_with_damage():
		health = health - 20
		
		if health <= 0:
			self.queue_free()

func _on_hitbox_area_entered(area):
	if area is Bullet:
		print("HIT")
		deal_with_damage()
