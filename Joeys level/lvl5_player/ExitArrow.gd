extends Marker2D


func _process(delta):
	# Get the target node using the exported absolute node path
	var exit = get_node("/root/Debug_or_die/ReynoldsSpawnPoint")
	
	look_at(exit.global_position)
