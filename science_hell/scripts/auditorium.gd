"""
auditorium.gd - Handles when the player enters the auditorium
"""
extends Node2D

func _ready():
	pass

# When player enters, the roof disappears
func _on_aud_area_body_entered(body):
	if(body.has_method("player")):
		SceneManager.reveal_scene("AudRoof", false, 0.3)

# When the player exits, the roof appears
func _on_aud_area_body_exited(body):
	if(body.has_method("player")):
		SceneManager.reveal_scene("AudRoof", true, 0.3)
