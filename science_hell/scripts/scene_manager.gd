extends Node

var current_scene = null
var current_scene_name = null
var player_position = null
var was_health_visible = null
var player_start_position = Vector2(-25, 55)


# TO use in other scripts
#Global.change_scene("res://ivan_level/Level/level.tscn")

var scene_node_paths = {
	"labroof": "Lab/Roof",
	"audroof": "Auditorium/Roof",
	"bathroof":"Bathroom1/Roof", 
	"parthroof": "ParthOffice/Roof"
}

var scene_file_paths = {
	"loading": "res://science_hell/gui/loading_screen/loading.tscn",
	"titlescreen": "res://science_hell/gui/Title Screen/menu.tscn",
	"lab": "res://science_hell/scenes/lab.tscn",
	"auditorium": "res://science_hell/scenes/auditorium.tscn", 
	"bathroom1": "res://science_hell/scenes/bathroom1.tscn",
	"sciencehall": "res://science_hell/src_scene/science_hell.tscn",
	"ivanlevel" : "res://ivan_level/level/level.tscn",
	"char_select": "res://science_hell/gui/char_select/character_select.tscn",
	"reynoldslevel": "res://Joeys level/level/debug_or_die.tscn",
	"pause": "res://science_hell/gui/Pause/pause.tscn",
	"copperslevel": "res://chey/Game.tscn",
	"jasonslevel": "res://level1(jason)//Scenes/Game.tscn",
	"parthlevel": "res://Level4/Scenes/FinalVirusWorld.tscn",
	"cooperlevel": "res://chey/Game.tscn",
	
	#cut scenes
	"reynoldscutscene": "res://science_hell/scenes/reynolds_cutscene.tscn"
}

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	print(current_scene)


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
	
	if current_scene_name == "char_select":
		player_position = player_start_position

	if scene_file_paths.has(scene_name):
		var new_scene_path = scene_file_paths[scene_name]
		current_scene_name = scene_name
		
		# Show the loading scene
		var loading_scene = load(scene_file_paths["loading"]).instantiate()
		get_tree().root.add_child(loading_scene)
		
		#track hearts visibility
		was_health_visible = Health.visible
		Health.set_visibility(false)
		
		# Request to load the target scene
		ResourceLoader.load_threaded_request(new_scene_path)
		
		var loading_status = ResourceLoader.THREAD_LOAD_IN_PROGRESS
		var progress = [0.0]
		
		while loading_status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			# Update the status
			loading_status = ResourceLoader.load_threaded_get_status(new_scene_path, progress)
			
			# Check the loading status
			match loading_status:
				ResourceLoader.THREAD_LOAD_IN_PROGRESS:
					# Update the progress bar value using the update_progress function
					loading_scene.update_progress(progress[0] * 2)
				ResourceLoader.THREAD_LOAD_LOADED:
					# When done loading, change to the target scene
					var new_scene = ResourceLoader.load_threaded_get(new_scene_path)
					
					# Yield for a frame before changing the scene
					await get_tree().process_frame
					
					# Remove the loading scene and change to the new scene
					get_tree().root.remove_child(loading_scene)
					loading_scene.queue_free()
					call_deferred("_deferred_change_scene", new_scene)
					return
				ResourceLoader.THREAD_LOAD_FAILED:
					# Handle the error
					print("Error. Could not load Resource")
					get_tree().root.remove_child(loading_scene)
					loading_scene.queue_free()
					return
			
			# Yield for a frame to allow the progress bar to update
			await get_tree().process_frame
	else:
		push_error("Scene not found in the dictionary: " + scene_name)

func _deferred_change_scene(new_scene):
	if is_instance_valid(current_scene):
		current_scene.queue_free()
		
	if was_health_visible:
		Health.set_visibility(was_health_visible)
	
	current_scene = new_scene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	
	
