"""
pause.gd - Handles the pause menu of the game
"""
extends Control

# scenes that will not return to science hall when you quit in pause menu
var base_scenes = ["sciencehall", "char_select", "titlescreen"]

# Tells how much computer parts the player has
func _process(delta):
	$ui/Label.text = str(PlayerStats.computer_parts) + "/5 Computer Parts"
	
	if Input.is_action_just_pressed("ui_cancel"):
		_on_resume_pressed()

# Resume button
func _on_resume_pressed():
	var canvas = get_parent()
	canvas.queue_free()
	get_tree().paused = false

# Quit button
func _on_quit_pressed():
	MusicManager.stop_music()
	var canvas = get_parent()
	canvas.queue_free()
	
	if base_scenes.has(SceneManager.current_scene_name):
		SceneManager.change_scene("titlescreen")
	
	else:
		SceneManager.change_scene("sciencehall")
		
	get_tree().paused = false
