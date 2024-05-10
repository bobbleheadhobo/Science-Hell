"""
science_hell.gd - Handles the main SH map
"""
extends Node

func _ready():
	MusicManager.play_song("sciencehall")
	Health.set_visibility(true)
	Health.set_main_location()
	$NPCSpawn.spawn_unselected_players()

# When player enters Reynolds' office, the player goes to his level
func _on_reynolds_office_body_entered(body):
	if(body.has_method("player")):
		SceneManager.change_scene("reynoldscutscene")

# When player enters Ivan's office, the player goes to his level
func _on_ivans_office_2_body_entered(body):
	if(body.has_method("player")):
		SceneManager.change_scene("ivanlevel")

# When player enters Parth's office, the player goes to his level
func _on_parth_office_body_entered(body):
	if(body.has_method("player")):
		SceneManager.change_scene("parthcutscene")

# When player enters the terminal area, the player goes to Cooper's level
func _on_cooper_6_body_entered(body):
	if(body.has_method("player")):
		SceneManager.change_scene("cooperlevel")

# Reynolds cutscene
func _on_reynolds_cutscene_body_entered(body):
	if(body.has_method("player")):
		SceneManager.change_scene("reynoldscutscene")
