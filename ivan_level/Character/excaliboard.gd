extends Area2D

const BULLET = preload("res://ivan_level/Character/excaliboard_bullet.tscn")
@onready var gun = get_node("Sprite2D")

var curr_bullet = null

func shoot():
	print("HERE SHOOT")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %shooting_point.global_position
	new_bullet.global_rotation = global_rotation
	
	var direction = Vector2.RIGHT.rotated(global_rotation)
	direction = Vector2(-1,0)
	print("Global position: ", new_bullet.global_position)
	print("Direction: ", direction)
	new_bullet.set_direction(direction)
	
	get_tree().current_scene.add_child(new_bullet)
	new_bullet.play_shoot_animation()
	curr_bullet = new_bullet

func left():
	gun.flip_h = true

func right():
	gun.flip_h = false
