extends Node


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

	return "You go %s" % second_word

# PRE: input help by user
# POST: displays users commands avaliable
func help() -> String:
	return "You can use these commands: go [location], help"
