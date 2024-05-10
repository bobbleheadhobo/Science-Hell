"""
lab.gd - Handles when the player enters the lab
"""
extends Node2D

# When player enters, the roof disappears
func _on_lab_area_body_entered(body):
	if(body.has_method("player")):
		SceneManager.reveal_scene("LabRoof", false, 0.3)

# When player enters, the roof appears
func _on_lab_area_body_exited(body):
	if(body.has_method("player")):
		SceneManager.reveal_scene("LabRoof", true, 0.3)
