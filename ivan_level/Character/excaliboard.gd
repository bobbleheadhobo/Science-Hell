extends Area2D

@onready var gun = get_node("AnimatedSprite2D")

func left():
	gun.play("left")

func right():
	gun.play("right")
