extends Node2D

func _on_area_2d_2_body_entered(body):
	if(body.has_method("player")):
		print("Player entered")
		SceneManager.change_scene("ivanlevel")