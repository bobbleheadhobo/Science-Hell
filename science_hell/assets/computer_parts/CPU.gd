"""
CPU.gd - Handles the CPU computer part, which can only be obtained when you complete
Chey's level
"""
extends Area2D

var entered = 0 # To process only once

func _ready():
	set_collision_setting(false)

# Once Chey's level is beat, the CPU spawns
func _process(delta):
	if PlayerStats.chey_level_complete and entered < 1:
		set_collision_setting(true)

# Handles the visibilty and ability to pick up the CPU
func set_collision_setting(tag):
		if tag:
			self.show()
			self.set_deferred("monitoring", true)
			$CollisionShape2D.set_deferred("disabled", false)
			entered += 1
		
		else:
			self.hide()
			self.set_deferred("monitoring", false)
			$CollisionShape2D.set_deferred("disabled", true)

# Function that allows the player to pickup the CPU
func _on_body_entered(body):
	if body is Hero and PlayerStats.chey_level_complete:
		PlayerStats.computer_parts += 1
		$"../ui/Label".text = "
		CPU acquired."
		
		set_collision_setting(false)
		await get_tree().create_timer(5.0).timeout
		$"../ui/Label".text = ""
		
		self.queue_free()
