extends Node2D

func _ready():
	var background = $Background
	print(background)
	pass

func _on_lab_area_body_entered(body):
	if(body.has_method("player")):
		SceneManager.reveal_scene("LabRoof", false, 0.3)

func _on_lab_area_body_exited(body):
	if(body.has_method("player")):
		SceneManager.reveal_scene("LabRoof", true, 0.3)
		
