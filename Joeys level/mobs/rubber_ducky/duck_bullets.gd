extends Area2D

var travelled_distance = 0
var direction = Vector2.ZERO

func _ready():
	# Rotate the bullet sprite to match the direction
	var angle = direction.angle()
	rotation = angle

func _physics_process(delta):
	const SPEED = 70
	const RANGE = 200
	
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()

func _on_body_entered(body):
	print("body entered")
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()

func play_shoot_animation(speed = 1):
	%AnimationPlayer.play("pew_pew", 1, speed)

func set_direction(dir):
	direction = dir
	$Sprite2D.rotation = direction.angle()
