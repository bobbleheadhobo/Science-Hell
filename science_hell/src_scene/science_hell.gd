extends Node



func _ready():
	# Used to keep track of starting positon and exit for lab 
	if MG.game_first_loadin == true:
		$hero.position.x = MG.player_start_x
		$hero.position.y = MG.player_start_y
	else:
		$hero.position.x = MG.player_exit_x
		$hero.position.y = MG.player_exit_y

func _process(delta):
	change_scene()

# Used for transitioning MC between lab 
func _on_lab_transition_body_entered(body):
	if body.has_method("player"):
		MG.transition_scene = true

func change_scene():
	if MG.transition_scene == true: 
		if MG.current_scene == "ScienceHell": 
			var lab = load("res://science_hell/scenes/lab.tscn")
			get_tree().change_scene_to_packed(lab)
			MG.game_first_loadin = false 
			MG.finish_change_scene()

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
