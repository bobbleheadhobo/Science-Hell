extends Node


func _ready() -> void:
	
	# unlock stack room only from terminal room
	var exit = $TerminalRoom.connect_exit_locked("south", $StackRoom) # , "inside"
	var key = load_item("DuckieKey")
	var duckie = load_npc("Duckie")
	
	$TerminalRoom.add_npc(duckie)
	# add key item to stack room only
	$TerminalRoom.add_item(key)
	key.use_value = exit # key item unlocks Stack room
	# exit stack room takes player to heap
	exit = $StackRoom.connect_exit_locked("south", $HeapRoom)
	
	
	var token = load_item("BugToken")
	var bug = load_npc("Bug")
	$StackRoom.add_item(token)
	$StackRoom.add_npc(bug)
	# use the NPC as the object not the item
	bug.quest_reward = exit
	
	# token unlocks heap room from stack room
	exit  = $HeapRoom.connect_exit_locked("south", $TextRoom)
	
	# add roopa to heap room
	var roopa = load_npc("Roopa")
	$HeapRoom.add_npc(roopa)
	# add roopa's items to heap room
	
	# texy room
	$TextRoom.connect_exit_unlocked("south", $CodeRoom)
	var text_duckie = load_npc("TextDuckie")
	$TextRoom.add_npc(text_duckie)
	$TextRoom.connect_exit_unlocked("west", $HintRoom)
	
	
	# hint room
	$HintRoom.connect_exit_unlocked("east", $TextRoom)
	var text_cooper = load_npc("Cooper")
	$HintRoom.add_npc(text_cooper)
	
	# code room
	$CodeRoom.connect_exit_unlocked("east", $BashRoom)
	var main = load_npc("Main")
	$CodeRoom.add_npc(main)
	
	# bash room
	$BashRoom.connect_exit_locked("east", $CodeShRoom)
	var bash_duckie = load_npc("BashDuckie")
	$BashRoom.add_npc(bash_duckie)
	
	# code.sh room
	$CodeShRoom.connect_exit_unlocked("east", $CooperRoom)
	var bats = load_npc("Bats")
	$CodeShRoom.add_npc(bats)

	# cooper 2 room
	$TerminalRoom.connect_exit_locked("east", $Cooper2Room)
	$Cooper2Room.connect_exit_locked("east", $ExitRoom)
	var cooper2 = load_npc("Cooper2")
	$Cooper2Room.add_npc(cooper2)
	
	# SH terminal Exit room
	$ExitRoom.connect_exit_locked("west", $Cooper2Room)
	var sh_cooper = load_npc("SHCooper")
	var sh_duckie = load_npc("SHDuckie")
	$ExitRoom.add_npc(sh_cooper)
	$ExitRoom.add_npc(sh_duckie)
	
	
	
# helper dynamic file fider for item resources
func load_item(item_name: String):
	return load("res://chey/items/" + item_name + ".tres")
	
# helper dynamic file fider for npcs resources
func load_npc(npc_name: String):
	return load("res://chey/npcs/" + npc_name + ".tres")

#func _enter_tree():
	## Override the scale for this specific scene
	#ScaleManager.set_stretch_scale(1.0)
#
#func _exit_tree():
	## Reset the scale to the global setting when leaving the scene
	#ScaleManager.set_stretch_scale(ScaleManager.original_scale)
