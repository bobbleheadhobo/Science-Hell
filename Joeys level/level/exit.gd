extends Area2D


func _on_body_entered(body):
	print("exit entered")
	if body.has_method("player") and Rey.game_over:
		#call_deferred("change")
		print("exiting")
		SceneManager.change_scene("Sciencehall")
		

func change():
	SceneManager.change_scene("Sciencehall")
