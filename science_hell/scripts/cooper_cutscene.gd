#plays cutscene then switches to coresponding level
extends Control

var animation_name = "cooper_cutscene"

func _ready():
	Health.set_visibility(false)
	var animation_length = $AnimationPlayer.get_animation(animation_name).length
	$AnimationPlayer.play(animation_name)
	await get_tree().create_timer(animation_length+1).timeout
	SceneManager.change_scene("cooperlevel")
	Health.set_visibility(true)
	
