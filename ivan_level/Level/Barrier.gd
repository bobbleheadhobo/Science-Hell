"""
barrier.gd - Handles the barrier of the boss room, so when player enters, they can't leave
"""
extends StaticBody2D

@onready var barrier = get_node("CollisionShape2D")

var player_entered = false

# Initially, barrier is disabled
func _ready():
	barrier.set_disabled(true)

# On entry, the barrier is activated
func _on_boss_room_body_entered(body):
	if body is Player:
		player_entered = true
		barrier.set_deferred("disabled", false)
		Health.reset_hearts()
