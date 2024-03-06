extends Control

# script class not instance of game => save data
const InputResponse = preload("res://chey/input_response.tscn")

# value can be edited in editor with export
@export var max_lines_remembered := 30

# references to input child nodes (only down the tree)
# $ => get access to node/scene of tree (has to be in scene tree)
# happens on ready()
@onready var history_rows = $Background/MarginContainer/Rows/GameInfo/Scroll/HistoryRows
@onready var scroll = $Background/MarginContainer/Rows/GameInfo/Scroll
# connect to the property
@onready var scrollbar = scroll.get_v_scroll_bar()


func _ready() -> void:
	# connect scroll bar changed signal to Game.gd
	scrollbar.connect("changed",handle_scrollbar_changed)

# handles scrollbar action
func handle_scrollbar_changed():
	# implement scroll to bottom
	scroll.scroll_vertical = scrollbar.max_value
	
func _on_input_text_submitted(new_text: String) -> void:
	# dont return on empty line of text
	if new_text.is_empty():
		return
	
	# contains instance of IR scene 
	var input_response = InputResponse.instantiate()
	
	# response property displays with each new text
	input_response.set_text(new_text, "This is where response will go")
	
	# add scene to child as history rows
	history_rows.add_child(input_response)
	
	# 
	if history_rows.get_child_count() > max_lines_remembered:
		# get the history rows children
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		# go through history rows 
		for i in range(rows_to_forget):
			# delete child node from tree and memory
			history_rows.get_child(i).queue_free()
