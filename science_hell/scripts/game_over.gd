"""
game_over.gd - Handles the game over UI
"""
extends Control

func _ready():
	Health.set_visibility(false)

# When drop out is pressed, the player goes back to the title screen
func _on_drop_out_pressed():
	MusicManager.stop_music()	
	get_tree().paused = false
	SceneManager.change_scene("titlescreen")
	$".".queue_free()
	Health.reset_hearts()

# When retry is pressed, the player starts back in science hall
func _on_retry_pressed():
	MusicManager.stop_music()
	get_tree().paused = false
	SceneManager.change_scene("sciencehall")
	$".".queue_free()
	Health.reset_hearts()

# Connect the buttons to their function
func connect_buttons():
	$drop_out.pressed.connect(self._on_drop_out_pressed)
	$retry.pressed.connect(self._on_retry_pressed)
