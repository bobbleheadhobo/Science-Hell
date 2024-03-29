extends Node

# signal for response text that needs to be sent to game script
#signal response_generated(response_text)

# no room
var current_room = null

# starting player
var player = null


# function gets called when room node needs to run
func intialize(starting_room, player) -> String:
	self.player = player
	return change_room(starting_room)

func process_command(input: String) -> String:
	# accept spaces false= no empty words
	var words = input.split(" ", false)
	if words.size() == 0:
		return "Error: no words were parsed."
	# first word and in lower case
	var first_word = words[0].to_lower()
	var second_word = ""
	if words.size() > 1:
		second_word = words[1].to_lower()
	# switch cases for commands
	match first_word:
		"go": 
			return go(second_word)
		"take":
			return take(second_word)
		"inventory":
			return inventory()
		"drop":
			return drop(second_word)
		"help":
			return help()
		# defualt case for invalid input
		_:
			return "Unrecognized command - please try again."	
			
			
# PRE function call
# POST returns command action for go
func go(second_word: String) -> String:
	if second_word == "":
		return "Go where?"
	# check if room can be exitable
	if current_room.exits.keys().has(second_word):
		var exit = current_room.exits[second_word]
		var change_response = change_room(exit.get_other_room(current_room))
		return "\n".join(PackedStringArray(["You go %s." % second_word, change_response]))
	else:
		return "That room has no exit in that direction!"

func take(second_word: String) -> String:
	if second_word == "":
		return "Take what?"
	
	# finds item when take[item] command used
	for item in current_room.items:
		if second_word.to_lower() == item.item_name.to_lower():
			current_room.remove_item(item)
			player.take_item(item)
			return "You take the " + item.item_name
	# error message
	return "The item " + second_word + "does not exist."
		
# player drops item command
func drop(second_word: String) -> String:
	if second_word == "":
		return "Drop what?"
	# drop item for player	
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			player.drop_item(item)
			current_room.add_item(item)
			return "You drop the " + item.item_name
	return "You don't have that item."
	
	
func inventory() -> String:
	return player.get_inventory_list()


# PRE: input help by user
# POST: displays users commands avaliable
func help() -> String:
	return "You can use these commands: go [location], take[item], inventory, drop[item], help"

# helper function to change rooms for us
func change_room(new_room: GameRoom) -> String:
	current_room = new_room
	return new_room.get_full_description()
