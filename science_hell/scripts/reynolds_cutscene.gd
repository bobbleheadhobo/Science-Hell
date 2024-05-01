extends Control

var animation_name = "reynolds_cutscene"

func _ready():
	var animation_length = $AnimationPlayer.get_animation(animation_name).length
	$AnimationPlayer.play(animation_name)
	print(animation_length)
	await get_tree().create_timer(animation_length+1).timeout
	SceneManager.change_scene("sciencehall")
