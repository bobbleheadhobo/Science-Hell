# data container

extends Resource
class_name Exit

# determine each exit and if it is locked or not
var room_1 = null
var room_2 = null

#var room_1_is_locked := false
var is_locked := false

## lock room
#var room_2_is_locked := false


func is_other_room_locked(current_room) -> bool:
	if current_room == room_1: # in room 1 (current room)
		return is_locked # lock room 2
	elif current_room == room_2: # in room 2 
		return is_locked # lock room 1
	else:
		printerr("sudo access required.")
		return true # true prevent player from trying exit again

func get_other_room(current_room):
	if current_room == room_1:
		return room_2
	elif current_room == room_2:
		return room_1
	else:
		printerr("sudo access required.")
		return null
