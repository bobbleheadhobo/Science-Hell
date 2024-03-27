extends Node


func _ready() -> void:
	$TerminalRoom.connect_exit("east", $StackRoom)


