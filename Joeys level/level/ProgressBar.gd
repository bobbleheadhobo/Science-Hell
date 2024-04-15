extends ProgressBar

func _ready():
	pass


func _on_spawners_container_update_progress_mob_killed():
		value += 1  # Increment the progress bar value by 10
