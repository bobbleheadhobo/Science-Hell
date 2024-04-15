extends Node2D

signal update_progress_mob_killed

var spawner_positions = []

var mobs = {
	"bat": preload("res://Joeys level/mobs/bat/bat.tscn"),
	"null_nightmare": preload("res://Joeys level/mobs/null_nightmares/null_nightmare.tscn"),
	"ducky": preload("res://Joeys level/mobs/rubber_ducky/Duck.tscn")
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
	
	# Connect the mob's "mob_killed" signal to the spawner's "_on_mob_killed" method
	var _error = new_mob.mob_killed.connect(self._on_mob_killed)
	
func choose_mob():
	var mob_keys = mobs.keys()
	var current_wave = Rey.current_wave

	# Select the appropriate mob based on the current wave
	if current_wave == 1:
		# Spawn only the first mob (null_nightmare) for wave 1
		return mobs[mob_keys[0]]
	elif current_wave == 2:
		# Spawn the first two mobs (null_nightmare and ducky) for wave 2
		var selected_keys = mob_keys.slice(0, 2)
		var random_key = selected_keys[randi() % selected_keys.size()]
		return mobs[random_key]
	else:
		# Spawn all mobs for wave 3 and above
		var random_key = mob_keys[randi() % mob_keys.size()]
		return mobs[random_key]
		
func _on_spawn_mob_timer_timeout():
	var new_mob = choose_mob()
	spawn_mob(new_mob)
	
func _on_mob_killed():
	print("mob killed")
	emit_signal("update_progress_mob_killed")
