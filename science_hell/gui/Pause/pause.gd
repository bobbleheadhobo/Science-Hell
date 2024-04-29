extends Control

# scenes that will not return to science hall when you quit in pause menu
var base_scenes = ["sciencehall", "char_select", "titlescreen"]

func _on_resume_pressed():
	var canvas = get_parent()
	canvas.queue_free()
	get_tree().paused = false

func _on_quit_pressed():
	MusicManager.stop_music()
	var canvas = get_parent()
	canvas.queue_free()
	get_tree().paused = false
	
	SceneManager.player_position = Vector2(-25, 55)
	SceneManager.change_scene("titlescreen")
