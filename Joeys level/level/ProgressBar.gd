extends ProgressBar

signal progress_bar_full

func _ready():
	max_value = 50
	value = 0  

func _on_spawners_container_update_progress_mob_killed():
	value += 10  # Increment the progress bar value by 10
	print(Rey.current_wave, Rey.MAX_WAVES)

	if value >= max_value and Rey.current_wave < Rey.MAX_WAVES:
		#increment to next wave
		emit_signal("progress_bar_full")
		max_value += 20
		
		if Rey.current_wave == Rey.MAX_WAVES:
			value = max_value 
		else:
			value = 0
