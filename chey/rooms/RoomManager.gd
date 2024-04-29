extends Node


func _ready() -> void:

	# unlock stack room only from terminal room
	var exit = $TerminalRoom.connect_exit_locked("south", $StackRoom) # , "inside"
	var key = load_item("DuckieKey")
	var duckie = load_npc("Duckie")
	var tb = load_item("TBUsless")
	
	$TerminalRoom.add_npc(duckie)
	# add key item to stack room only
	$TerminalRoom.add_item(key)
	key.use_value = exit # key item unlocks Stack room
	# exit stack room takes player to heap
	exit = $StackRoom.connect_exit_locked("south", $HeapRoom)
	
	
	var dead = load_item("Dead")
	var token = load_item("BugToken")
	var bug = load_npc("Bug")
	$StackRoom.add_item(token)
	$StackRoom.add_item(dead)
	$StackRoom.add_npc(bug)
	# use the NPC as the object not the item
	bug.quest_reward = exit
	
	# token unlocks heap room from stack room
	$HeapRoom.connect_exit_unlocked("south", $TextRoom)
	var roopa = load_npc("Roopa") # add roopa to heap room
	var r = load_item("RPassword")
	var mal = load_item("Mal")
	$HeapRoom.add_item(r)
	$HeapRoom.add_item(mal)
	$HeapRoom.add_npc(roopa)

	# texy room
	$TextRoom.connect_exit_unlocked("south", $CodeRoom)
	var ff = load_item("FF")
	var nu = load_item("Nil")
	var text_duckie = load_npc("TextDuckie")
	$TextRoom.add_item(ff)
	$TextRoom.add_item(nu)
	$TextRoom.add_npc(text_duckie)
	$TextRoom.connect_exit_unlocked("west", $HintRoom)
	
	
	# hint room
	$HintRoom.connect_exit_unlocked("east", $TextRoom)
	var text_cooper = load_npc("Cooper")
	var f = load_item("FPassword")
	var EC = load_item("ECPassword")
	
	$HintRoom.add_item(f)
	$HintRoom.add_item(EC)
	$HintRoom.add_npc(text_cooper)
	
	
	# code room
	exit = $CodeRoom.connect_exit_unlocked("east", $BashRoom)
	var b = load_item("BPassword")
	var eof = load_item("EOF")
	var main = load_npc("Main")
	$CodeRoom.add_item(b)
	$CodeRoom.add_item(eof)
	$CodeRoom.add_npc(main)

	
	# bash room
	$BashRoom.connect_exit_unlocked("east", $CodeShRoom)
	var bash_duckie = load_npc("BashDuckie")
	var a = load_item("APassword")
	var bye = load_item("Bye")
	var bats = load_npc("Bats")
	
	$BashRoom.add_item(a)
	$BashRoom.add_item(bye)
	$BashRoom.add_npc(bash_duckie)
	$BashRoom.add_npc(bats)
	
	#### EAST OF TERMINAL ####
	# cooper 2 room
	$TerminalRoom.connect_exit_unlocked("east", $Cooper2Room)
	$Cooper2Room.connect_exit_unlocked("east", $ExitRoom)
	var sh_duckie = load_npc("SHDuckie")
	var cooper2 = load_npc("Cooper2")
	var seg = load_item("Seg")
	var save = load_item("SaveCooper")
	$Cooper2Room.add_item(seg)
	$Cooper2Room.add_item(save)
	$Cooper2Room.add_npc(cooper2)
	$Cooper2Room.add_npc(sh_duckie)

	# SH terminal Exit room
	$ExitRoom.connect_exit_unlocked("west", $Cooper2Room)
	var sh_cooper = load_npc("SHCooper")
	$ExitRoom.add_npc(sh_cooper)




# helper dynamic file fider for item resources
func load_item(item_name: String):
	return load("res://chey/items/" + item_name + ".tres")
	
# helper dynamic file fider for npcs resources
func load_npc(npc_name: String):
	return load("res://chey/npcs/" + npc_name + ".tres")


