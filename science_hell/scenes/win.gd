extends Control

func _ready():
	Health.set_visibility(false)
	$AnimationPlayer.play("WIN")
	await get_tree().create_timer(15.0).timeout
	$AnimationPlayer.play("slide")
	await get_tree().create_timer(5.0, 1, 1.4).timeout	
	SceneManager.change_scene("titlescreen")
	Health.reset_hearts()
