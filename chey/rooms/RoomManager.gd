extends Node


func _ready() -> void:
	
	
	
	
	
	# unlock stack room only from terminal room
	var exit = $TerminalRoom.connect_exit_locked("south", $StackRoom) # , "inside"
	var key = load_item("TerminalKey")
	var bug = load_npc("Bug")
	$TerminalRoom.add_npc(bug)
	# add key item to stack room only
	$TerminalRoom.add_item(key)
	key.use_value = exit # key item unlocks Stack room
	# add key item to stack room only

	

	
	
	# exit stack room takes player to heap
	exit = $StackRoom.connect_exit_locked("south", $HeapRoom)
	var duckie = load_npc("Duckie")
	$StackRoom.add_npc(duckie)
	var token = load_item("DuckieToken")
	$StackRoom.add_item(token)
	token.use_value = exit
	exit = $HeapRoom.connect_exit_locked("south", $TextRoom)
	
	$TextRoom.connect_exit_locked("south", $CodeRoom)
	$TextRoom.connect_exit_locked("west", $HintRoom)
	
	
	$CodeRoom.connect_exit_locked("east", $BashRoom)
	$BashRoom.connect_exit_locked("east", $CodeShRoom)
	
	$CodeShRoom.connect_exit_locked("east", $CooperRoom)
	

	$TerminalRoom.connect_exit_locked("east", $Cooper2Room)
	$Cooper2Room.connect_exit_locked("east", $ExitRoom)
	
# helper dynamic file fider for item resources
func load_item(item_name: String):
	return load("res://chey/items/" + item_name + ".tres")
	
# helper dynamic file fider for npcs resources
func load_npc(npc_name: String):
	return load("res://chey/npcs/" + npc_name + ".tres")
