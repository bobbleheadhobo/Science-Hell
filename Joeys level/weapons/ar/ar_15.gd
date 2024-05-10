# this code control how the STAFF works it is not longer a gun

extends Area2D
const BULLET = preload("res://Joeys level/weapons/AR/ar_bullet.tscn")
var enemy_position = null

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		enemy_position = target_enemy.global_position

func shoot():
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %shooting_point.global_position
	
	if enemy_position != null:
		var direction = (enemy_position - %shooting_point.global_position).normalized()
		new_bullet.set_direction(direction)
	else:
		# If no enemy position is available, set a default direction
		var default_direction = Vector2.RIGHT
		new_bullet.set_direction(default_direction)
	
	get_tree().current_scene.add_child(new_bullet)
	new_bullet.play_shoot_animation()

func flip_sprite(flip: bool):
	if flip:
		$ar.flip_h = flip
		$ar.position.x = -70
	elif not flip:
		$ar.flip_h = flip
		$ar.position.x = 7		
	else:
		push_error("Unknown command in ar_15 script flip spirte func")
