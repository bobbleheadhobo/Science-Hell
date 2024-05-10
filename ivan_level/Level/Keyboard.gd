"""
keyboard.gd - Handles the keyboard sprite, so that the player can acquire it
"""
extends Area2D

@onready var game_over = null
@onready var level = $".."
var entered = 0 # To process only once

# Keyboard is disabled and hidden until player beats the level
func _ready():
	set_collision_setting(false)

# Once the level is beat, the keyboard appears to collect
func _process(delta):
	if game_over and entered < 1:
		set_collision_setting(true)
		

# Function that controls whether the keyboard is hidden or not
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

# Function that handles the event when player collects the keyboard
func _on_body_entered(body):
	if body is Player and game_over:
		PlayerStats.computer_parts += 1
		PlayerStats.inventory.append("keyboard")
		$"../ui/Label".text = "
		Keyboard acquired."
		set_collision_setting(false)
		level.level_over()
