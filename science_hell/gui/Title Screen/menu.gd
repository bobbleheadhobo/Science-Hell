"""
menu.gd - Handles the main title screen UI
"""
extends Control

func _ready():
	Health.set_visibility(false)
	MusicManager.play_song("menu")
	SceneManager.current_scene_name = "titlescreen"

# When play is pressed, it goes to the character select screen
func _on_play_pressed():	
	SceneManager.change_scene("char_select")

# Options is there for aesthestic
func _on_options_pressed():
	pass

# When exit is pressed, the game closes
func _on_exit_pressed():
	get_tree().quit()
