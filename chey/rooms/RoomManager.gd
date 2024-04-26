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
	exit  = $HeapRoom.connect_exit_unlocked("south", $TextRoom)
	
	# add roopa to heap room
	var roopa = load_npc("Roopa")
	$HeapRoom.add_npc(roopa)

	# texy room
	$TextRoom.connect_exit_unlocked("south", $CodeRoom)
	var text_duckie = load_npc("TextDuckie")
	$TextRoom.add_npc(text_duckie)
	#text_duckie.quest_reward = exit
	
	$TextRoom.connect_exit_unlocked("west", $HintRoom)
	
	# cooper 2 room
	exit = $TerminalRoom.connect_exit_locked("east", $Cooper2Room)
	$Cooper2Room.connect_exit_locked("east", $ExitRoom)
	#var duckieToken = load_item("DuckieToken")
	var cooper2 = load_npc("Cooper2")
	#$Cooper2Room.add_item(duckieToken)
	$Cooper2Room.add_npc(cooper2)
	
	# hint room
	$HintRoom.connect_exit_unlocked("east", $TextRoom)
	var text_cooper = load_npc("Cooper")
	$HintRoom.add_npc(text_cooper)
	
	
	# code room
	exit = $CodeRoom.connect_exit_unlocked("east", $BashRoom)
	var main = load_npc("Main")
	$CodeRoom.add_npc(main)
	
	# bash room
	$BashRoom.connect_exit_unlocked("east", $CodeShRoom)
	var bash_duckie = load_npc("BashDuckie")
	$BashRoom.add_npc(bash_duckie)
	
	# code.sh room
	$CodeShRoom.connect_exit_unlocked("east", $CooperRoom)
	var bats = load_npc("Bats")
	$CodeShRoom.add_npc(bats)


	
	# SH terminal Exit room
	$ExitRoom.connect_exit_locked("west", $Cooper2Room)
	var sh_cooper = load_npc("SHCooper")
	var sh_duckie = load_npc("SHDuckie")
	$ExitRoom.add_npc(sh_cooper)
	$ExitRoom.add_npc(sh_duckie)
	
	# if quest item recieved to cooper
	#SceneManager.change_scene('sciencehall')
	
	
	
# helper dynamic file fider for item resources
func load_item(item_name: String):
	return load("res://chey/items/" + item_name + ".tres")
	
# helper dynamic file fider for npcs resources
func load_npc(npc_name: String):
	return load("res://chey/npcs/" + npc_name + ".tres")


