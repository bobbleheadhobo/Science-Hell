@tool # tool script executes each room scene
extends PanelContainer
class_name GameRoom

# create setters
@export var room_name:String = "Room Name":set = set_room_name
@export_multiline var room_description:String = "This is the description of the room.": set = set_room_description

# add exits room
var exits: Dictionary = {}


# setter method: updates value and variable in editor for labels
func set_room_name(new_name: String):
	# update value
	$MarginContainer/Rows/RoomName.text = new_name
	# update variable
	room_name = new_name
	
	
# setter: update room desciption in editor and game
func  set_room_description(new_description: String):
	$MarginContainer/Rows/RoomDescription.text = new_description
	room_description = new_description
	
# connect exit only runs when function is called
func connect_exit(direction: String, room: GameRoom):
	# instance a new exit (Resource Object)
	var exit = Exit.new()
	exit.room_1 = self #connects to itself
	exit.room_2 = room # room connecting to
	exits[direction] = exit # exit resource (connect both ways)
	
	# connect both cardinal directions of connection
	match direction:
		"west":
			room.exits["east"] = exit # resource
		"east":
			room.exits["west"] = exit
		"north":
			room.exits["south"] = exit
		"south":
			room.exits["north"] = exit
		_:
			printerr("Tried to connect invalid direction: %s", direction)
