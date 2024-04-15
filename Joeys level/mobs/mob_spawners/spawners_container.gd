extends Node2D

var spawner_positions = []

var mobs = {
	"null_nightmare": preload("res://Joeys level/mobs/null_nightmares/null_nightmare.tscn"),
	"ducky": preload("res://Joeys level/mobs/rubber_ducky/Duck.tscn"),
	"bat": preload("res://Joeys level/mobs/bat/bat.tscn")
}

func _ready():
	for child in get_children():
		if child is Marker2D:
			spawner_positions.append(child.global_position)

func spawn_mob(mob):
	if spawner_positions.is_empty():
		return

	var spawn_position = spawner_positions[randi() % spawner_positions.size()]
	var new_mob = mob.instantiate()
	add_child(new_mob)
	new_mob.global_position = spawn_position
	
func choose_mob():
	var mob_keys = mobs.keys()
	var random_key = mob_keys[randi() % mob_keys.size()]
	var random_mob = mobs[random_key]
	return random_mob

func _on_spawn_mob_timer_timeout():
	var new_mob = choose_mob()
	spawn_mob(new_mob)
