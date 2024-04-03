extends Node2D

func _process(delta):
	change_scenes()


func _on_lab_exit_body_exited(body):
	print("lab exit")
	if body.has_method("player"):
		print("is player")
		MG.transition_scene = false
		
		
func change_scenes():
	if MG.transition_scene == true:
		if MG.current_scene == "Lab":
			get_tree().change_scene_to_file("res://science_hell/src_node/science_hell.tscn")
			MG.finish_change_scene()
