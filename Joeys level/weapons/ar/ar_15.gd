extends Area2D

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)

func shoot():
	print("PEW!")
	const BULLET = preload("res://Joeys level/weapons/AR/ar_bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %shooting_point.global_position
	new_bullet.global_rotation = global_rotation
	
	var direction = Vector2.RIGHT.rotated(global_rotation)
	new_bullet.set_direction(direction)
	
	get_tree().current_scene.add_child(new_bullet)
	new_bullet.play_shoot_animation()
