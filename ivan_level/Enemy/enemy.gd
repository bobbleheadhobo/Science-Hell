"""
enemy.gd - Handles the 404 enemy sprites mechanics
"""
extends CharacterBody2D

var speed = 25
var player_chase = false
var player = null

var health = 100
var player_inattack_zone = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Processes the enemies movements
func _physics_process(delta):
	if player_chase:
		position += (player.position - position) / speed
		velocity.y += gravity * delta

# When player enters enemy's detection area
func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

# When player exits enemy's detection area
func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func enemy():
	pass

# Function to process player's damage
func deal_with_damage():
		health = health - 25
		print("Slime health = ", health)
		
		if health <= 0:
			self.queue_free()

# Function to process when bullet enters enemy's hitbox
func _on_enemy_hitbox_area_entered(area):
	if area is Bullet:
		print("HIT")
		deal_with_damage()
