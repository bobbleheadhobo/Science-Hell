extends Node


func _ready() -> void:
	#### EAST OF TERMINAL ####
	# cooper 2 room
	var exit = $TerminalRoom.connect_exit_locked("east", $Cooper2Room)
	$Cooper2Room.connect_exit_unlocked("east", $ExitRoom)
	var cooper2 = load_npc("Cooper2")
	var roopa = load_npc("Roopa") 
	var r_token = load_item("RoopaToken")	
	var seg = load_item("Seg")
	var save = load_item("SaveCooper")
	$Cooper2Room.add_item(seg)
	$Cooper2Room.add_item(save)
	$Cooper2Room.add_npc(cooper2)
	roopa.quest_reward = exit

	# SH terminal Exit room
	$ExitRoom.connect_exit_unlocked("west", $Cooper2Room)
	var sh_cooper = load_npc("SHCooper")
	var EC = load_item("ECPassword")
	# ! last token of passwd command
	$ExitRoom.add_item(EC) # !
	$ExitRoom.add_npc(sh_cooper)
	
	#### SOUTH OF TERMINAL ####
	
	# unlock stack room only from terminal room
	$TerminalRoom.connect_exit_unlocked("south", $StackRoom) # , "inside"
	var duckie = load_npc("Duckie")
	var tb = load_item("TBUseless")
	
	$TerminalRoom.add_item(tb)
	$TerminalRoom.add_npc(duckie)
	$StackRoom.connect_exit_unlocked("south", $HeapRoom)
	
	# add bug to stack room and items
	var dead = load_item("Dead")
	var bug = load_npc("Bug")
	
	var f = load_item("FPassword") # f
	$StackRoom.add_item(f)
	
	$StackRoom.add_item(dead)
	$StackRoom.add_npc(bug)
	
	# token unlocks terminal east room
	$HeapRoom.connect_exit_unlocked("south", $TextRoom)
	var r = load_item("RPassword") # r
	var mal = load_item("Mal")
	$HeapRoom.add_item(r)
	$HeapRoom.add_item(mal)
	$HeapRoom.add_npc(roopa)
	
	# texy room
	$TextRoom.connect_exit_unlocked("south", $CodeRoom)
	var a = load_item("APassword") # a
	var ff = load_item("FF")
	var nu = load_item("Nil")
	var text_duckie = load_npc("TextDuckie")
	
	$TextRoom.add_item(a)
	$TextRoom.add_item(ff)
	$TextRoom.add_item(nu)
	$TextRoom.add_npc(text_duckie)
	$TextRoom.connect_exit_unlocked("west", $HintRoom)
	
	
	# hint room
	$HintRoom.connect_exit_unlocked("east", $TextRoom)
	var text_cooper = load_npc("Cooper")
	$HintRoom.add_item(r_token)
	$HintRoom.add_npc(text_cooper)
	
	
	# code room
	exit = $CodeRoom.connect_exit_unlocked("east", $BashRoom)
	var b = load_item("BPassword")
	var eof = load_item("EOF")
	$CodeRoom.add_item(b)
	$CodeRoom.add_item(eof)

	
	# bash room
	$BashRoom.connect_exit_unlocked("east", $CodeShRoom)
	var bash_duckie = load_npc("BashDuckie")
	var bye = load_item("Bye")
	var key = load_item("Key")
	var bats = load_npc("Bats")
	
	$BashRoom.add_item(key)
	$BashRoom.add_item(bye)
	$BashRoom.add_npc(bash_duckie)
	$BashRoom.add_npc(bats)
	



# helper dynamic file fider for item resources
func load_item(item_name: String):
	return load("res://chey/items/" + item_name + ".tres")
	
# helper dynamic file fider for npcs resources
func load_npc(npc_name: String):
	return load("res://chey/npcs/" + npc_name + ".tres")


