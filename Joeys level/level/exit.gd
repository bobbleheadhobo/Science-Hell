extends Area2D


func _on_body_entered(body):
	if body.has_method("player") and Rey.game_over:
		$"../Map".open_elevator()
		await get_tree().create_timer(0.8).timeout
		SceneManager.change_scene("Sciencehall")
		
