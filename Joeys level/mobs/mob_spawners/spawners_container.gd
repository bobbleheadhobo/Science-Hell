extends Node2D

var spawner_positions = []

func _ready():
	for child in get_children():
		if child is Marker2D:
			spawner_positions.append(child.global_position)

func spawn_mob():
	if spawner_positions.is_empty():
		return

	var spawn_position = spawner_positions[randi() % spawner_positions.size()]
	var null_nightmare = preload("res://Joeys level/mobs/null_nightmares/null_nightmare.tscn").instantiate()
	add_child(null_nightmare)
	null_nightmare.global_position = spawn_position

func _on_spawn_mob_timer_timeout():
	spawn_mob()
