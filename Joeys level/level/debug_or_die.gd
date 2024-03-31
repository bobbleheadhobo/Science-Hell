extends Node2D

func spawn_mob():
	var null_nightmare = preload("res://Joeys level/mobs/null_nightmares/null_nightmare.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	null_nightmare.global_position = %PathFollow2D.global_position
	add_child(null_nightmare)


func _on_timer_timeout():
	spawn_mob()


func _on_player_health_empty():
	%GameOver.visible = true
	get_tree().paused = true
	

