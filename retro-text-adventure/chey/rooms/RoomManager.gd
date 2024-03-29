extends Node


func _ready() -> void:
	var key = Item.new()
	key.intialize("key", Types.ItemTypes.KEY) # prints to terminal
	$TerminalRoom.connect_exit("east", $StackRoom)
	
	# add key item to stack room only
	$StackRoom.add_item(key)
	# exit stack room takes player to heap
	$StackRoom.connect_exit("north", $HeapRoom)
	
	# add key item to heap room only
	$HeapRoom.add_item(key)
	# exit geap room takes player to text
	$HeapRoom.connect_exit("north", $TextRoom)
	
	# add key item to text room only
	$TextRoom.add_item(key)
	# exit text room takes player to code
	$TextRoom.connect_exit("north", $CodeRoom)
	
	# add key code to heap room only
	$CodeRoom.add_item(key)
	# exit code room takes player to cooper
	$CodeRoom.connect_exit("north", $CooperRoom)
	
	# add key item to cooper room only
	$CooperRoom.add_item(key)
	# exit cooper room takes player to terminal for now but main map soon
	$CooperRoom.connect_exit("north", $TerminalRoom)
