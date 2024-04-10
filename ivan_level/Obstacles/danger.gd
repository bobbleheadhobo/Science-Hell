extends Area2D

# Signal when player enters area


func _on_body_entered(body):
	if body is Player:
		body.handle_danger()
