extends Node

func _ready():
	MusicManager.play_song("sciencehall")
	Health.set_visibility(true)
	Health.set_main_location()
	$NPCSpawn.spawn_unselected_players()

func _on_reynolds_office_body_entered(body):
	if(body.has_method("player")):
		SceneManager.change_scene("reynoldslevel")

func _on_ivans_office_2_body_entered(body):
	if(body.has_method("player")):
		SceneManager.change_scene("ivanlevel")
