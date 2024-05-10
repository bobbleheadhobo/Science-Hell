"""
danger.gd - Handles the danger spots of the map; Like if player falls off map
"""
extends Area2D

# If player falls off map, they die and return to the start
func _on_body_entered(body):
	if body is Player:
		body.handle_danger()
