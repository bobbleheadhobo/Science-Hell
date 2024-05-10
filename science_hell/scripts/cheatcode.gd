extends Area2D

func _on_body_entered(body):
	if(body.has_method("player")):
		PlayerStats.computer_parts = 5
		SceneManager.change_scene("sciencehall")
