extends Control

# references to input child nodes (only down the tree)
# $ => get access to node/scene of tree (has to be in scene tree)
# happens on ready()

@onready var game_info = $Background/MarginContainer/Rows/GameInfo
@onready var command_processor = $CommandProcessor
# connect to room node
@onready var room_manager = $RoomManager
# connect to player 
@onready var player = $Player



# PRE: nada
# POST: main
func _ready() -> void:
	game_info.create_response(Types.wrap_system_text("Welcome to Science Hell... Type 'help' to see avaiable commands."))

	# connect before we intialize game
	#command_processor.response_generated.connect(handle_response_generated)
	var starting_room_response = command_processor.intialize(room_manager.get_child(0), player)
	game_info.create_response(starting_room_response)
	# intialize game to starting room for player
	#command_processor.intialize(room_manager.get_child(0))




  
# PRE param is text entered by player
# POST so much stuff
func _on_input_text_submitted(new_text: String) -> void:
	# dont return on empty line of text
	if new_text.is_empty():
		return

	# response to command from input
	var response = command_processor.process_command(new_text)
	game_info.create_response_with_input(response, new_text)



	



	
	
	

