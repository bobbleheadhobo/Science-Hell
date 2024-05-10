extends Area2D



func _on_body_entered(body):
	Health.update_health(0)
