#This code will spawn a mob when the timer fires

extends Marker2D

func spawn_mob():
	var null_nightmare = preload("res://Joeys level/mobs/null_nightmares/null_nightmare.tscn").instantiate()
	get_parent().add_child(null_nightmare)
	null_nightmare.global_position = global_position


func _on_spawn_mob_timer_timeout():
	spawn_mob()
