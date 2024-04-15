extends ProgressBar

signal progress_bar_full

func _ready():
	max_value = 100  # Set the maximum value of the progress bar
	value = 0  # Set the initial value of the progress bar

func _on_spawners_container_update_progress_mob_killed():
	print("updated value")
	value += 10  # Increment the progress bar value by 10

	if value >= max_value:
		emit_signal("progress_bar_full")
		value = 0  # Ensure the value doesn't exceed the maximum
