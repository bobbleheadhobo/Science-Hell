extends Node

@onready var progress_bar : ProgressBar = $CanvasLayer/ProgressBar

var colors = [Color.RED, Color.GREEN, Color.BLUE, Color.YELLOW, Color.ORANGE]
var current_color_index = 0

func _ready():
	Health.set_visibility(false)

	
func update_progress(progress):
	progress_bar.value = progress * 100
	
	# Get the next color in the colors array
	var next_color_index = (current_color_index + 1) % colors.size()
	var current_color = colors[current_color_index]
	var next_color = colors[next_color_index]
	
	# Create a new tween and animate the progress bar color
	var tween = get_tree().create_tween()
	tween.tween_property(progress_bar, "tint_progress", current_color, 0.5)
	tween.tween_property(progress_bar, "tint_progress", next_color, 0.5)
	
	# Update the current color index
	current_color_index = next_color_index
