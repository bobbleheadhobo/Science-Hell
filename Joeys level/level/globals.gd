extends Node
var mobs_killed = 0

func on_mob_killed():
	mobs_killed += 1
	update_progress_bar(mobs_killed)
	
	var progress_bar = get_node("CanvasLayer/ProgressBar")
	if mobs_killed >= progress_bar.max_value:
		#trigger_power_up()
		mobs_killed = 0  # Reset the mob kill count
	
func update_progress_bar(value):
	var progress_bar = get_node("CanvasLayer/ProgressBar")
	progress_bar.value = value

