
extends StaticBody2D

@onready var barrier = get_node("CollisionShape2D")

var player_entered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	barrier.set_disabled(true)

func _on_boss_room_body_entered(body):
	if body is Player:
		player_entered = true
		barrier.set_deferred("disabled", false)
		Health.reset_hearts()
