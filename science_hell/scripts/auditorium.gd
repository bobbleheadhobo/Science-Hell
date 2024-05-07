extends Node2D

func _ready():
	pass

func _on_aud_area_body_entered(body):
	if(body.has_method("player")):
		SceneManager.reveal_scene("AudRoof", false, 0.3)

func _on_aud_area_body_exited(body):
	if(body.has_method("player")):
		SceneManager.reveal_scene("AudRoof", true, 0.3)
