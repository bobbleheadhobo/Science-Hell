"""
RAM.gd - Handles the RAM computer part, which is acquired when Jason's level is beat
"""
extends Area2D


func _ready():
	set_collision_setting(false)

# Once Jason's level is beat, the RAM spawns
func _process(delta):
	if PlayerStats.jason_level_complete and not PlayerStats.inventory.has("ram"):
		set_collision_setting(true)

# Handles the visibilty and ability to pick up the RAM
func set_collision_setting(tag):
		if tag:
			self.show()
			self.set_deferred("monitoring", true)
			$CollisionShape2D.set_deferred("disabled", false)
		
		else:
			self.hide()
			self.set_deferred("monitoring", false)
			$CollisionShape2D.set_deferred("disabled", true)

# Function that allows the player to pickup the RAM
func _on_body_entered(body):
	if body is Hero and PlayerStats.jason_level_complete:
		PlayerStats.computer_parts += 1
		PlayerStats.inventory.append("ram")
		$"../ui/Label".text = "
		RAM acquired."
		
		set_collision_setting(false)
		
		await get_tree().create_timer(5.0).timeout
		$"../ui/Label".text = ""
		
		self.queue_free()
