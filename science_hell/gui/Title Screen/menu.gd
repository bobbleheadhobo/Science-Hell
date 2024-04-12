extends Control

func _ready():
	Health.set_visibility(false)
	MusicManager.play_song("menu")

func _on_play_pressed():	
	SceneManager.change_scene("char_select")
	
func _on_options_pressed():
	pass # Replace with function body.

func _on_exit_pressed():
	get_tree().quit()
