extends Control

func _on_resume_pressed():
	var canvas = get_parent()
	canvas.queue_free()
	get_tree().paused = false

func _on_quit_pressed():
	var canvas = get_parent()
	canvas.queue_free()
	get_tree().paused = false
	SceneManager.change_scene("titlescreen")
