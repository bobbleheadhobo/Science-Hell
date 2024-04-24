@tool # tool script executes each room scene
extends PanelContainer
class_name GameRoom

# create setters
@export var room_name:String = "Room Name":set = set_room_name
@export_multiline var room_description:String = "This is the description of the room.": set = set_room_description

# add exits room
var exits: Dictionary = {}
var npcs: Array = []
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

# add npc to room
func add_npc(npc: NPC):
	npcs.append(npc)

# remove npc to room
#func remove_npc(npc: NPC):
	#pass
	
	
# add item to room for player
func add_item(item: Item):
	items.append(item)

# removes item from room add error checking
func remove_item(item: Item):
	items.erase(item)


# all descriptions
func get_full_description() -> String:
	
	var full_description = PackedStringArray([get_room_description()])
	
	var npc_description = get_npc_description()
	if npc_description != "":
		full_description.append(npc_description)
	
	
	var item_description = get_item_description()
	if item_description != "":
		full_description.append(item_description)

	full_description.append(get_exit_description())

	var full_description_string = ("\n").join(full_description)
	return full_description_string


# room description
func get_room_description() -> String:
	return "\n" + "[color=#008080]Location: [/color]" + Types.wrap_location_text(room_name) + "\n" +"[color=#008080]Objective: [/color]" + Types.wrap_main_description(room_description) 
	

# npc dialog
func get_npc_description() -> String:
	if npcs.size() == 0:
		return ""
	var npc_string = ""
	for npc in npcs:
		npc_string += Types.wrap_npc_text(npc.npc_name) + " "
	return "\n[color=#008080]NPC:[/color] " +  npc_string 

# item description
func get_item_description() -> String:
	
	if items.size() == 0:
		return ""
	
	var item_string = ""
	for item in items:
		item_string += Types.wrap_item_text(item.item_name) + " "
	return "\n[color=#008080]Items:[/color] " +  item_string


# exit description
func get_exit_description() -> String:
	return  "\n[color=#008080]Exits:[/color] " + Types.wrap_location_text(" ".join(PackedStringArray(exits.keys())))


# handles telling player exit is unlocked
@warning_ignore("unused_parameter")
func connect_exit_unlocked(direction: String, room: GameRoom, room_2_override_name = "null"):
	return _connect_exit(direction, room, false) # false not locking exit


# handles locking exits
func connect_exit_locked(direction: String, room: GameRoom, room_2_override_name = "null"):
	return _connect_exit(direction, room, true, room_2_override_name) # true locking exit



## create function to lock both sides of room
#@warning_ignore("unused_parameter")
#func connect_both_exit_locked(direction: String, room: GameRoom, room_2_override_name):
	#pass



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
			"north":
				room.exits["south"] = exit
			"south":
				room.exits["north"] = exit
			"east":
				room.exits["west"] = exit
			"west":
				room.exits["east"] = exit
			_:
				printerr("Tried to connect invalid direction: %s", direction)
	return exit
