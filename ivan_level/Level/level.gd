"""
level.gd - Script that handles Ivan's level
"""
extends Node2D

# On player entry, the music queues
func _ready():
	MusicManager.play_song("ivan")

# When level is beat, player goes back to main map
func level_over():
	Health.reset_hearts()
	await get_tree().create_timer(0.1).timeout
	SceneManager.change_scene("Sciencehall")
