extends Node2D

var max_waves = 4
var is_game_over = false


func _ready():
	MusicManager.play_song("reynolds")
	Health.update_health(0)

func _on_progress_bar_progress_bar_full():
	Rey.next_wave()
	if Rey.current_wave == 1:
		$SpawnMobTimer.wait_time = 2
	elif Rey.current_wave == 2:
		$SpawnMobTimer.wait_time = 1
	else:
		$SpawnMobTimer.wait_time = 0.5
