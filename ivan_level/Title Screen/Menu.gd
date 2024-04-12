extends Control

func _ready():
	Health.set_visibility(false)
	MainMenu.play()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://science_hell/src_scene/science_hell.tscn")

func _on_options_pressed():
	pass # Replace with function body.

func _on_exit_pressed():
	get_tree().quit()
