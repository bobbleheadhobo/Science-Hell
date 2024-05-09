extends Node

@onready var progress_bar : ProgressBar = $CanvasLayer/ProgressBar

	
func update_progress(progress):
	progress_bar.value = progress * 100
