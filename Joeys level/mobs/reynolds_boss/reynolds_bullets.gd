extends Area2D

var travelled_distance = 0
var direction = Vector2.ZERO

func _ready():
	# Rotate the bullet sprite to match the direction
	var angle = direction.angle()
	rotation = angle

func _physics_process(delta):
	const SPEED = 600
	const RANGE = 500
	
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()

func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		var damage_direction = (body.global_position - global_position).normalized()
		body.take_damage(damage_direction)

func play_shoot_animation(speed = 1):
	$AnimationPlayer.play("pew_pew", 1, speed)

func set_direction(dir):
	direction = dir
	$Sprite2D.rotation = direction.angle()
