extends Control

# Response scene
const Response = preload("res://chey/input/Response.tscn")
# script class not instance of game => save data
const InputResponse = preload("res://chey/input/InputResponse.tscn")

# value can be edited in editor with export
@export var max_lines_remembered := 30

@onready var command_processor = $CommandProcessor

# references to input child nodes (only down the tree)
# $ => get access to node/scene of tree (has to be in scene tree)
# happens on ready()
@onready var history_rows = $Background/MarginContainer/Rows/GameInfo/Scroll/HistoryRows
@onready var scroll = $Background/MarginContainer/Rows/GameInfo/Scroll
# connect to the property
@onready var scrollbar = scroll.get_v_scroll_bar()
# connect to room node
@onready var room_manager = $RoomManager
# connect to player 
@onready var player = $Player



# PRE: nada
# POST: main
func _ready() -> void:
	# connect scroll bar changed signal to Game.gd
	scrollbar.connect("changed",handle_scrollbar_changed)

	create_response("Welcome to Science Hell... Type 'help' to see avaiable commands.")
	
	# connect before we intialize game
	#command_processor.response_generated.connect(handle_response_generated)
	var starting_room_response = command_processor.intialize(room_manager.get_child(0), player)
	create_response(starting_room_response)
	# intialize game to starting room for player
	#command_processor.intialize(room_manager.get_child(0))


# PRE connected scroll bar signal coming from ready
# POST handles scrollbar vertical action
func handle_scrollbar_changed():
	# implement scroll to bottom
	scroll.scroll_vertical = scrollbar.max_value

  
# PRE param is text entered by player
# POST so much stuff
func _on_input_text_submitted(new_text: String) -> void:
	# dont return on empty line of text
	if new_text.is_empty():
		return
	
	# contains instance of IR scene 
	var input_response = InputResponse.instantiate()
	# response to command from input
	var response = command_processor.process_command(new_text)
	
	# show user input (validation and scroll scroll history), new response from command processor
	input_response.set_text(new_text, response)

	# add response to game
	add_response_to_game(input_response)

# generate response for each room for player. responds to anything
func create_response(response_text: String):
	# instance of Respone and add response
	var response = Response.instantiate()
	# eventually use export var or JSON
	response.text = response_text
	add_response_to_game(response)
	


# PRE: from Response scene branch
# POST: adds response to game
func add_response_to_game(response: Control):
	# add scene to child as history rows
	history_rows.add_child(response)
	# deletes msg < 30 msgs
	delete_history_beyond_limit()
	
	
	
# PRE: called when on input sibmitted function is active
# POST: deletes msgs < 30 msgs
func delete_history_beyond_limit():
	if history_rows.get_child_count() > max_lines_remembered:
		# get the history rows children
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		# go through history rows 
		for i in range(rows_to_forget):
			# delete child node from tree and memory
			history_rows.get_child(i).queue_free()
