extends Control

# references to input child nodes (only down the tree)
# $ => get access to node/scene of tree (has to be in scene tree)
# happens on ready()

@onready var game_info = $Background/MarginContainer/Columns/Rows/GameInfo
@onready var command_processor = $CommandProcessor
# connect to room node
@onready var room_manager = $RoomManager
# connect to player 
@onready var player = $Player



# PRE: nada
# POST: main
func _ready() -> void:
	var side_panel = $Background/MarginContainer/Columns/SidePanel
	command_processor.room_changed.connect(Callable(side_panel, "handle_room_changed"))
	command_processor.room_updated.connect(Callable(side_panel, "handle_room_updated"))
	game_info.create_response(Types.wrap_system_text("Welcome to Science Hell... Type 'help' to see avaiable commands."))
	

	var starting_room_response = command_processor.intialize(room_manager.get_child(0), player)
	game_info.create_response(starting_room_response)
	
	#ScaleManager.set_stretch_scale(4.0)


func _exit_tree():
	# When the scene is exited, reset the scale to the original setting
	ScaleManager.reset_stretch_scale()
  
# PRE param is text entered by player
# POST so much stuff
func _on_input_text_submitted(new_text: String) -> void:
	# dont return on empty line of text
	if new_text.is_empty():
		return

	# response to command from input
	var response = command_processor.process_command(new_text)
	game_info.create_response_with_input(response, new_text)



	



	
	
	

