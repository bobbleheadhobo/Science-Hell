extends Node2D

signal boss_spawned(boss_node)
var max_waves = 4
var current_wave = Rey.current_wave
var reynolds_scene = preload("res://Joeys level/mobs/reynolds_boss/reynolds.tscn")
var exit_scene = preload("res://Joeys level/level/exit.tscn")


func _ready():
	MusicManager.play_song("reynolds")

func _on_progress_bar_progress_bar_full():
	current_wave = 	Rey.next_wave()
	if current_wave == 1:
		$SpawnMobTimer.wait_time = 2
		$ui/Label.text = "
		wave " + str(current_wave)
	elif current_wave == 2:
		$SpawnMobTimer.wait_time = 1
		$ui/Label.text = "
		wave " + str(current_wave)
	elif current_wave == 3:
		$SpawnMobTimer.wait_time = 0.5
		$ui/Label.text = "
		wave " + str(current_wave)
	elif current_wave == 4:
		$ui/Label.text = "
		FINAL WAVE"
		$SpawnMobTimer.wait_time = 1
		call_deferred("spawn_reynolds")
		
		
func spawn_reynolds():
	var reynolds = reynolds_scene.instantiate()
	reynolds.global_position = $ReynoldsSpawnPoint.global_position
	reynolds.level_over.connect(self.level_over)
	add_child(reynolds)
	emit_signal("boss_spawned", reynolds)
	
	
func level_over():
	$ui/Label.text = "
		YOU WON!"
	Rey.game_over = true
	kill_all("mobs")
	$lvl5_Player.show_arrow()
	

func kill_all(group_name):
	var nodes_in_group = get_tree().get_nodes_in_group(group_name)
	for node in nodes_in_group:
		node.queue_free()
