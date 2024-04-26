extends Area2D

var travelled_distance = 0
var direction = Vector2.ZERO

func _physics_process(delta):
	const SPEED = 700
	const RANGE = 600
	
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()

func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(global_position)

func play_shoot_animation():
	%AnimationPlayer.play("pew_pew")

func set_direction(dir):
	direction = dir
