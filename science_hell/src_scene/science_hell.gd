extends Node

@onready var pause_menu = $hero/Pause
var paused = false

func _ready():
	MusicManager.play_song("sciencehall")
	Health.set_visibility(true)

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()

func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused

func health_example():
	# change health example
	await get_tree().create_timer(1).timeout
	Health.update_health(Health.current_health - 1)
	
	await get_tree().create_timer(1).timeout
	Health.update_health(Health.current_health - 4)
	
	await get_tree().create_timer(2).timeout
	Health.update_health(Health.current_health + 3)
	
	await get_tree().create_timer(2).timeout
	Health.update_health(10)

func _on_reynolds_office_body_entered(body):
		if(body.has_method("player")):
			SceneManager.change_scene("reynoldslevel")
