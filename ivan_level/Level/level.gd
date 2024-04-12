extends Control

func _ready():
	Health.set_visibility(false)
	MainMenu.play()

func _on_play_pressed():
	SceneManager.change_scene("sciencehall")
	
func _on_options_pressed():
	pass # Replace with function body.

func _on_exit_pressed():
	get_tree().quit()
