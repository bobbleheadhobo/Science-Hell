extends Node


var scene_roofs = {
	"LabRoof": "Lab/Roof",
}


func reveal_scene(scene_name: String, show_scene: bool, fade_duration: float = 0.5):
	if scene_roofs.has(scene_name):
		var roof_path = scene_roofs[scene_name]
		var scene_root = get_tree().current_scene
		var roof = scene_root.get_node(roof_path)
		
		if roof:
			if show_scene:
				# Fade in
				roof.modulate.a = 0.0
				roof.visible = true
				var tween = create_tween()
				tween.tween_property(roof, "modulate:a", 1.0, fade_duration)
			else:
				# Fade out
				var tween = create_tween()
				tween.tween_property(roof, "modulate:a", 0.0, fade_duration)
				tween.tween_callback(roof.set_visible.bind(false))
		else:
			push_error("node not found: " + roof_path)
	else:
		push_error("node path not defined for scene: " + scene_name)


#TODO
func change_scene():
	pass
