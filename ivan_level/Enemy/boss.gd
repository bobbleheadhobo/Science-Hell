class_name Boss
extends CharacterBody2D

var speed = 40
var player_chase = false
var player = null

var health = 10
var player_inattack_zone = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var keyboard = $"../Keyboard"

func _physics_process(delta):
	#if $"../TileMap/Barrier".player_entered:
	#	$ui/Label.text = "Bugzilla: " + str(health)
	
	if player_chase:
		position += (player.position - position) / speed

		move_and_slide()
		update_direction(player.direction.x)

func update_direction(dir):
	if dir != 0:
		if dir > 0:
			$AnimatedSprite2D.flip_h = false
	
		elif dir < 0:
			$AnimatedSprite2D.flip_h = true

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
		health = health - 35
		
		if health <= 0:
			print("BOSS defeated")
			self.queue_free() 
			keyboard.game_over = true
			

func _on_hitbox_area_entered(area):
	if area is Bullet:
		print("HIT")
		deal_with_damage()
