"""
bathroom1.gd - Handles when the player enters the bathroom
"""
extends Node2D
	
func _ready():
	pass

# When player enters, the roof disappears
func _on_bathroom_1_area_body_entered(body):
	if(body.has_method("player")):
		SceneManager.reveal_scene("BathRoof", false, 0.3)	

# When player exits, the roof appears
func _on_bathroom_1_area_body_exited(body):
	if(body.has_method("player")):
		SceneManager.reveal_scene("BathRoof", true, 0.3)
