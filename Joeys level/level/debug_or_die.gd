extends Node2D

var max_waves = 4
var is_game_over = false
var current_wave = Rey.current_wave


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
		spawn_reynolds()
		
		
func spawn_reynolds():
	var reynolds = load("res://Joeys level/mobs/reynolds_boss/reynolds.tscn").instantiate()
	reynolds.global_position = $ReynoldsSpawnPoint.global_position
	add_child(reynolds)
	
	
