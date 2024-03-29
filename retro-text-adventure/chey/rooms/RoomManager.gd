extends Node


func _ready() -> void:
	var key = Item.new()
	key.intialize("key", Types.ItemTypes.KEY) # prints to terminal
	$TerminalRoom.connect_exit("east", $StackRoom)
	$TerminalRoom.add_item(key)


