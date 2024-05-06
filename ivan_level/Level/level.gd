extends Node2D

@onready var acquired = null

func _ready():
	MusicManager.play_song("ivan")

func _process(delta):
	if acquired:
		level_over()

func level_over():
	Health.reset_hearts()
	await get_tree().create_timer(0.8).timeout
	SceneManager.change_scene("Sciencehall")
