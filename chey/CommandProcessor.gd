extends Node


signal room_changed(new_room)
signal room_updated(current_room)


# no room
var current_room = null

# starting player
var player = null


# function gets called when room node needs to run
@warning_ignore("shadowed_variable")
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
		"cd": 
			return cd(second_word)
		"take":
			return take(second_word)
		"inventory":
			return inventory()
		"drop":
			return drop(second_word)
		"use":
			return use(second_word)
		"talk":
			return talk(second_word)
		"give":
			return give(second_word)
		"help":
			return help()
		# defualt case for invalid input
		_:
			return Types.wrap_system_text("Unrecognized command - please try again.")
			
			
# PRE function call
# POST returns command action for go
func cd(second_word: String) -> String:
	if second_word == "":
		return Types.wrap_system_text("Go where?")
	# getting all keys and check if room can be exitable
	if current_room.exits.keys().has(second_word):
		var exit = current_room.exits[second_word]
		if exit.is_locked:
			return "The way " + Types.wrap_location_text(second_word) + " is currently " + Types.wrap_system_text(" locked!") 
			
		var change_response = change_room(exit.get_other_room(current_room))
		return "\n".join(PackedStringArray(["You go " + Types.wrap_location_text(second_word) + ".", change_response]))
	else:
		return "This room has no " +Types.wrap_location_text(second_word) + " exit."


func take(second_word: String) -> String:
	if second_word == "":
		return Types.wrap_system_text("Take what?")
	
	# finds item when take[item] command used
	for item in current_room.items:
		if second_word.to_lower() == item.item_name.to_lower():
			current_room.remove_item(item)
			player.take_item(item)
			emit_signal("room_updated", current_room)
			return "You take the " + Types.wrap_item_text(second_word) + "."
	# error message
	return  "There is no " + Types.wrap_item_text(second_word) + " here."


# player drops item command
func drop(second_word: String) -> String:
	if second_word == "":
		return Types.wrap_system_text("Drop what?")
	# drop item for player
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			player.drop_item(item)
			current_room.add_item(item)
			emit_signal("room_updated", current_room)
			return "You drop the " + Types.wrap_item_text(item.item_name) + "."
	return "You don't have anything called " + Types.wrap_item_text(second_word) + "."
	



func inventory() -> String:
	return player.get_inventory_list()


# handles use command mechanics to use item
func use(second_word: String) -> String:
	if second_word == "":
		return Types.wrap_system_text("Use what?")
		
	# loop through all items in players inventory
	for item in player.inventory:
		# comand == valid item nme
		if second_word.to_lower() == item.item_name.to_lower(): 
			# get what type of item it is
			match item.item_type:
				# item = key
				Types.ItemTypes.KEY:
					# unlock a door
					# make sure room is connected to the exit we are currently in
					for exit in current_room.exits.values():
						# player is in a valid room with a valid exit and item is in current room that has a valid item to unlock room 2 for player
						if exit == item.use_value: 
							# unlock the room
							exit.is_locked = false
							player.drop_item(item) # removes item from player inventory
							return "You use a " + Types.wrap_item_text(second_word) + " to unlock the way " + Types.wrap_location_text(exit.get_other_room(current_room).room_name) + "."
						return "Your " + Types.wrap_item_text(second_word) + " does not unlock anything here."

				_: # invalid item
					return "Error - item cannot be used this way."

	return "You don't have a " + Types.wrap_item_text(second_word) + "."


# handles npc dialog
func talk(second_word: String) -> String:
	if second_word == "":
		return Types.wrap_system_text("Talk to who?")
		
	# print npc dialog
	for npc in current_room.npcs:
		if npc.npc_name.to_lower() == second_word:
			var dialog = npc.post_quest_dialog if npc.has_recieved_quest_item else npc.initial_dialog
			return Types.wrap_npc_text(npc.npc_name + ": ") + Types.wrap_speech_text("\"" + dialog + "\"")

			
	return "There is no " + Types.wrap_npc_text(second_word) + " here."


func give(second_word: String) -> String:
	
	if second_word == "":
		return  Types.wrap_system_text("Give what?")

	var has_item := false
	# check if player has item in their inventory
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			has_item = true

	if not has_item:
		return "You don't have a " + Types.wrap_item_text(second_word) + "."
		

	# find NPC that wants item
	for npc in current_room.npcs:
		if npc.quest_item != null and second_word.to_lower() == npc.quest_item.item_name.to_lower():
			npc.has_recieved_quest_item = true
			if npc.quest_reward != null:
				# unlock an exit
				# duck typing = determines type of object by name and what it does not Item type
				var reward = npc.quest_reward
				# in = checks for property in the object
				# if our reward is something that can be locked
				if "is_locked" in reward:
					# unlock it as part of the quest reward
					reward.is_locked = false

				# note to developer warning error
				else:
					printerr("Warning - tried to have a quest reward type that is not implemented.")
			
			# remove item from player inventory
			for item in player.inventory:
				if second_word.to_lower() == item.item_name.to_lower():
					player.drop_item(item)

			return "You give the " + Types.wrap_item_text(second_word) + " to the " +  Types.wrap_npc_text(npc.npc_name) + "."

	return "Nobody here wants a" + Types.wrap_item_text(second_word) + "."


# PRE: input help by user
# POST: displays users commands avaliable
func help() -> String:
	return "\n".join(PackedStringArray([
		"You can use these commands: ",
		" cd " + Types.wrap_location_text("[location]"),
		" take " + Types.wrap_item_text("[item]"),
		" drop " + Types.wrap_item_text("[item]"),
		" use " + Types.wrap_item_text("[item]"),
		" talk " + Types.wrap_npc_text("[npc]"),
		" give " + Types.wrap_item_text("[item]"),
		" inventory",
		" help"]))

# helper function to change rooms for us
func change_room(new_room: GameRoom) -> String:
	current_room = new_room
	emit_signal("room_changed", new_room)
	return new_room.get_full_description()
