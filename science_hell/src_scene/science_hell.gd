extends Node

func _ready():
	MusicManager.play_song("sciencehall")
	Health.set_visibility(true)
	Health.set_main_location()
	$NPCSpawn.spawn_unselected_players()
	$NPCSpawn.spawn_professors()
	
	if PlayerStats.computer_parts > 0 or PlayerStats.chey_level_complete or PlayerStats.jason_level_complete and PlayerStats.computer_parts < PlayerStats.num_winning_parts:
		$HamBody2DStart.queue_free()
	
	if PlayerStats.computer_parts >= PlayerStats.num_winning_parts:
		$HamBody2DFinish.show()
	
	
	print(PlayerStats.inventory)
	

func _on_reynolds_office_body_entered(body):
	if(body.has_method("player")):
		SceneManager.change_scene("reynoldscutscene")

func _on_ivans_office_2_body_entered(body):
	if(body.has_method("player")):
		SceneManager.change_scene("ivanlevel")
		
func _on_parth_office_body_entered(body):
	if(body.has_method("player")):
		SceneManager.change_scene("parthcutscene")


func _on_cooper_6_body_entered(body):
	if(body.has_method("player")):
		SceneManager.change_scene("cooperlevel")


func _on_reynolds_cutscene_body_entered(body):
	if(body.has_method("player")):
		SceneManager.change_scene("reynoldscutscene")


		
		
