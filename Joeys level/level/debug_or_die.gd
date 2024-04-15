extends Node2D



func _ready():
	MusicManager.play_song("reynolds")


func _on_player_health_empty():
	%GameOver.visible = true
	get_tree().paused = true
	

