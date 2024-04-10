extends Node

var current_scene = null

# TO use in other scripts
#Global.change_scene("res://ivan_level/Level/level.tscn")

var scene_node_paths = {
	"labroof": "Lab/Roof",
}

var scene_file_paths = {
	"lab": "res://science_hell/scenes/lab.tscn",
	"sciencehall": "res://science_hell/src_scene/science_hell.tscn",
	"ivanlevel" : "res://ivan_level/level/level.tscn"
}

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	print(current_scene)
	#pass


func reveal_scene(scene_name: String, show_scene: bool, fade_duration: float = 0.5):
	scene_name = scene_name.to_lower()
	if scene_node_paths.has(scene_name):
		var roof_path = scene_node_paths[scene_name]
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
		
func change_scene(scene_name: String):
	scene_name = scene_name.to_lower()

	if scene_file_paths.has(scene_name):
		var new_scene_path = scene_file_paths[scene_name]
		call_deferred("_deferred_change_scene", new_scene_path)
	else:
		push_error("Scene not found in the dictionary: " + scene_name)

func _deferred_change_scene(new_scene_path):
	current_scene.free()
	var new_scene = ResourceLoader.load(new_scene_path)
	current_scene = new_scene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	
