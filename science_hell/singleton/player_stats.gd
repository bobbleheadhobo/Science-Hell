extends Node

@onready var computer_parts = 0
@onready var chey_level_complete = false
@onready var jason_level_complete = false

func _process(delta):
	if computer_parts >= 5:
		#Game won
		pass
