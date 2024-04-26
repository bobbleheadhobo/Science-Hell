extends Area2D

@onready var gun = get_node("Sprite2D")

func left():
	gun.flip_h = true

func right():
	gun.flip_h = false
