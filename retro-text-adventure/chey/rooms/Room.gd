@tool # tool script executes each room scene
extends PanelContainer
class_name GameRoom

# create setters
@export var room_name:String = "Room Name":set = set_room_name
@export_multiline var room_description:String = "This is the description of the room.": set = set_room_description

# add exits room
var exits: Dictionary = {}
var items: Array = [] # hold enum items in array

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

# add item to room for player
func add_item(item: Item):
	items.append(item)

# removes item from room add error checking
func remove_item(item: Item):
	items.erase(item)


# all descriptions
func get_full_description() -> String:
	
	var full_description =  "\n".join(PackedStringArray([
		get_room_description(),
		get_item_description(),
		get_exit_description()
	]))
	return full_description


# room description
func get_room_description() -> String:
	return "You are now in: " + room_name + ". " + room_description
	

# item description
func get_item_description() -> String:
	
	if items.size() == 0:
		return "No items to pick up."
	
	var item_string = ""
	for item in items:
		item_string += item.item_name + " "
	return "Items: " +  item_string


# exit description
func get_exit_description() -> String:
	return "Exits: " + " ".join(PackedStringArray(exits.keys()))

# handles telling player exit is unlocked
func connect_exit_unlocked(direction: String, room: GameRoom, room_2_override_name = "null"):
	return _connect_exit(direction, room, false) # false not locking exit

# handles locking exits
func connect_exit_locked(direction: String, room: GameRoom, room_2_override_name = "null"):
	return _connect_exit(direction, room, true, room_2_override_name) # true locking exit


# create function to lock both sides of room
func connect_both_exit_locked(direction: String, room: GameRoom, room_2_override_name):
	pass


# using as private function _
# connect exit only runs when function is called
func _connect_exit(direction: String, room: GameRoom, is_locked: bool = false, room_2_override_name = "null"):
	# instance a new exit (Resource Object)
	var exit = Exit.new()
	exit.room_1 = self #connects to itself
	exit.room_2 = room # room connecting to
	exit.is_locked = is_locked # dependent on param if its true or false
	exits[direction] = exit # exit resource (connect both ways)
	
	# connect exit to override name
	if room_2_override_name != "null":
		room.exits[room_2_override_name] = exit
	else: # no override name
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
			"path":
				room.exits["path"] = exit
			"inside":
				room.exits["outside"] = exit
			"outside":
				room.exits["inside"] = exit
			_:
				printerr("Tried to connect invalid direction: %s", direction)
	return exit
