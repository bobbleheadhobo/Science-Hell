extends Node


func _ready() -> void:
	var key = Item.new()
	key.intialize("key", Types.ItemTypes.KEY) # set item to its enum
	$TerminalRoom.connect_exit("east", $StackRoom)
	$TerminalRoom.add_item(key)


