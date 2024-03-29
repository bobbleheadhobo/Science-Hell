extends Node


func _ready() -> void:
	var key = Item.new()
	key.intialize("key", Types.ItemTypes.KEY) # prints to terminal
	key.use_value = $StackRoom # key item unlocks Stack room
	
	# add key item to stack room only
	$TerminalRoom.add_item(key)
	# unlock stack room only from terminal room
	$TerminalRoom.connect_exit_locked("east", $StackRoom)
	
	# add key item to stack room only
	#$StackRoom.add_item(key)
	# exit stack room takes player to heap
	$StackRoom.connect_exit_locked("north", $HeapRoom)
	
	# add key item to heap room only
	$HeapRoom.add_item(key)
	# exit geap room takes player to text
	$HeapRoom.connect_exit_locked("north", $TextRoom)
	
	# add key item to text room only
	$TextRoom.add_item(key)
	# exit text room takes player to code
	$TextRoom.connect_exit_locked("north", $CodeRoom)
	
	# add key code to heap room only
	$CodeRoom.add_item(key)
	# exit code room takes player to cooper
	$CodeRoom.connect_exit_locked("north", $CooperRoom)
	
	# add key item to cooper room only
	$CooperRoom.add_item(key)
	# exit cooper room takes player to terminal for now but main map soon
	$CooperRoom.connect_exit_locked("north", $TerminalRoom)
	
	# lock cooper room from terminal room 
	$TerminalRoom.connect_exit_locked("south", $CooperRoom) 
