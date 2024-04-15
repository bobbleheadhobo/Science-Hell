extends Node2D

var max_waves = 4

func _ready():
	MusicManager.play_song("reynolds")


func _on_player_health_empty():
	%GameOver.visible = true
	get_tree().paused = true


func _on_progress_bar_progress_bar_full():
	Rey.next_wave()
	
	if Rey.current_wave == 1:
		$SpawnMobTimer.wait_time = 2
	elif Rey.current_wave == 2:
		$SpawnMobTimer.wait_time = 1
	else:
		$SpawnMobTimer.wait_time = 0.5
		
	
