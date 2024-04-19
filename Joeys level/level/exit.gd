extends Area2D


func _on_body_entered(body):
	if body.has_method("player"):
		call_deferred("change")

func change():
	SceneManager.change_scene("Sciencehall")
