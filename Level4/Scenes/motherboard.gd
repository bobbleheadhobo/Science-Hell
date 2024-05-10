extends Node2D

func _ready():
	$AnimationPlayer.play("hover")

func _on_area_2d_body_entered(body):
	if(body.has_method("player")):
		PlayerStats.computer_parts += 1
		PlayerStats.inventory.append("motherboard")
		queue_free()
		SceneManager.change_scene("sciencehall")
		
