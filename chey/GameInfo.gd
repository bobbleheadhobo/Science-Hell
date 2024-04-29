extends PanelContainer

# Response scene
#const Response = preload("res://chey/input/Response.tscn")

# script class not instance of game => save data
const INPUT_RESPONSE = preload("res://chey/input/InputResponse.tscn")

# value can be edited in editor with export
@export var max_lines_remembered := 30

# flag determines if room needs to be zebra or not
var should_zebra := false

@onready var scroll = $Scroll
# connect to the property
@onready var scrollbar = scroll.get_v_scroll_bar()

@onready var history_rows = $Scroll/HistoryRows


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# connect scroll bar changed signal to Game.gd
	scrollbar.connect("changed",_handle_scrollbar_changed)
	#max_scroll_length = scrollbar.max_value # new
	#Health.set_visibility(false)
	
	

##### PUBLIC #####

# generate response for each room for player. responds to anything
func create_response(response_text: String):
	# instance of Respone and add response
	var response = INPUT_RESPONSE.instantiate()
	# eventually use export var or JSON
	_add_response_to_game(response)
	response.set_text(response_text)
	
# generate response for each room for player. responds to anything
func create_response_with_input(response_text: String, input_text: String):
	var input_response = INPUT_RESPONSE.instantiate()
	
	# show user input (validation and scroll scroll history), new response from command processor
	# add response to game
	_add_response_to_game(input_response)
	input_response.set_text( response_text, input_text)

##### PRIVATE #####
# PRE connected scroll bar signal coming from ready
# POST handles scrollbar vertical action
func _handle_scrollbar_changed():
	# implement scroll to bottom
	#if max_scroll_length != scrollbar.max_value:
		#max_scroll_length = scrollbar.max_value # new
	scroll.scroll_vertical = scrollbar.max_value


# PRE: called when on input sibmitted function is active
# POST: deletes msgs < 30 msgs
func _delete_history_beyond_limit():
	if history_rows.get_child_count() > max_lines_remembered:
		# get the history rows children
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		# go through history rows 
		for i in range(rows_to_forget):
			# delete child node from tree and memory
			history_rows.get_child(i).queue_free()
			
			
			
# PRE: PRIVATE FUNCTION from Response scene branch
# POST: adds response to game
func _add_response_to_game(response: Control):
	# add scene to child as history rows
	history_rows.add_child(response)
	
	# add zebra to room
	if not should_zebra:
		response.zebra.hide()
	# flips to true or false if it should be zebra trick
	should_zebra = !should_zebra
	
	# deletes msg < 30 msgs
	_delete_history_beyond_limit()
