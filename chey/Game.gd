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

@onready var camera = $Camera2D

# PRE: nada
# POST: main
func _ready() -> void:
	var side_panel = $Background/MarginContainer/Columns/SidePanel
	command_processor.room_changed.connect(Callable(side_panel, "handle_room_changed"))
	command_processor.room_updated.connect(Callable(side_panel, "handle_room_updated"))
	game_info.create_response(Types.wrap_system_text("Welcome to Science Hell... Type 'help' to see avaiable commands."))
	

	var starting_room_response = command_processor.intialize(room_manager.get_child(0), player)
	game_info.create_response(starting_room_response)
	
	#camera.zoom = Vector2(0.4, 0.4) # Since 1/4 is the inverse of 4, if the global scale is 4
	var global_scale = 2.4
	camera.zoom = Vector2(1.0 / global_scale, 1.0 / global_scale)
  
# PRE param is text entered by player
# POST so much stuff
func _on_input_text_submitted(new_text: String) -> void:
	# dont return on empty line of text
	if new_text.is_empty():
		return

	# response to command from input
	var response = command_processor.process_command(new_text)
	game_info.create_response_with_input(response, new_text)



	



	
	
	

