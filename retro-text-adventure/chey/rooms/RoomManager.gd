extends Node


func _ready() -> void:
	
	
	
	
	
	# unlock stack room only from terminal room
	var exit = $TerminalRoom.connect_exit_locked("/stack", $StackRoom) # , "inside"
	var key = load_item("Key")
	var bug = load_npc("Bug")
	$TerminalRoom.add_npc(bug)
	# add key item to stack room only
	$TerminalRoom.add_item(key)
	key.use_value = exit # key item unlocks Stack room

	
	# add key item to stack room only
	#$StackRoom.add_item(key)
	
	
	# exit stack room takes player to heap
	exit = $StackRoom.connect_exit_locked("/heap", $HeapRoom)
	
	#$StackRoom.connect_exit_unlocked("/terminal", $Terminal)
	# exit geap room takes player to text
	$HeapRoom.connect_exit_locked("/text", $TextRoom)
	

	# exit text room takes player to code
	$TextRoom.connect_exit_locked("/code", $CodeRoom)
	

	# exit code room takes player to cooper
	$CodeRoom.connect_exit_locked("/cooper1", $CooperRoom)
	
	# cooper 1 room with npc
	$CooperRoom.connect_exit_locked("/hint.txt", $HintRoom)
	var cooper = load_npc("Cooper")
	$CooperRoom.add_npc(cooper)
	
	# hint room
	$HintRoom.connect_exit_locked("/bash_profile", $BashRoom)
	
	# bash profile room
	$BashRoom.connect_exit_locked("/code.sh", $CodeShRoom)
	
	# code.sh room
	$CodeShRoom.connect_exit_locked("/cooper2", $Cooper2Room)
	
	# cooper 2 final room
	$Cooper2Room.connect_exit_locked("exit", $ExitRoom)
	

	
# helper dynamic file fider for item resources
func load_item(item_name: String):
	return load("res://chey/items/" + item_name + ".tres")
	
# helper dynamic file fider for npcs resources
func load_npc(npc_name: String):
	return load("res://chey/npcs/" + npc_name + ".tres")
