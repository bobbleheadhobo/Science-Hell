extends Node


func _ready() -> void:
	
	
	
	
	
	# unlock stack room only from terminal room
	var exit = $TerminalRoom.connect_exit_unlocked("south", $StackRoom) # , "inside"
	var key = load_item("Key")
	var bug = load_npc("Bug")
	$TerminalRoom.add_npc(bug)
	# add key item to stack room only
	$TerminalRoom.add_item(key)
	key.use_value = exit # key item unlocks Stack room

	
	# add key item to stack room only
	#$StackRoom.add_item(key)
	
	
	# exit stack room takes player to heap
	exit = $StackRoom.connect_exit_locked("east", $HeapRoom)
	

	# exit geap room takes player to text
	$HeapRoom.connect_exit_unlocked("north", $TextRoom)
	

	# exit text room takes player to code
	$TextRoom.connect_exit_unlocked("west", $CodeRoom)
	

	# exit code room takes player to cooper
	$CodeRoom.connect_exit_unlocked("north", $CooperRoom)
	
	var cooper = load_npc("Cooper")
	$CooperRoom.add_npc(cooper)	
	# exit cooper room takes player to terminal for now but main map soon
	$CooperRoom.connect_exit_unlocked("south", $TerminalRoom)
	# lock cooper room from terminal room 
	#$TerminalRoom.connect_exit_unlocked("south", $CooperRoom)
	
# helper dynamic file fider for item resources
func load_item(item_name: String):
	return load("res://chey/items/" + item_name + ".tres")
	
# helper dynamic file fider for npcs resources
func load_npc(npc_name: String):
	return load("res://chey/npcs/" + npc_name + ".tres")
