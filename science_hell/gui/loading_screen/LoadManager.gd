extends Node

var loading_status : int
var progress : Array[float]
var target_scene_path
var current_scene

@onready var progress_bar : ProgressBar = $ProgressBar

func show_loading_screen(new_scene_path, current):
	$LoadingScreen.show()
	ResourceLoader.load_threaded_request(new_scene_path)
	target_scene_path = new_scene_path
	current_scene = current
	
func hide_loading_screen():
	$LoadingScreen.hide()

func _process(_delta: float) -> void:
	# Update the status
	#loading_status = ResourceLoader.load_threaded_get_status(target_scene_path, progress)

	# Check the loading status:
	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			progress_bar.value = progress[0] * 100 # Change the ProgressBar value
		ResourceLoader.THREAD_LOAD_LOADED:
		# When done loading, change to the target scene:
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(target_scene_path))
			current_scene.free()
			var new_scene = ResourceLoader.load(target_scene_path)
			current_scene = new_scene.instantiate()
			get_tree().root.add_child(current_scene)
			get_tree().current_scene = current_scene
		ResourceLoader.THREAD_LOAD_FAILED:
		# Well some error happened:
			print("Error. Could not load Resource")
			hide_loading_screen()
