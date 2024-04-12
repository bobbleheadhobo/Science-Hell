extends Node


func _ready():
	MusicManager.stop_music()

func _process(delta):
	pass

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

