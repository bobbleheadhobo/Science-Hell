extends Node

@onready var pause_scene = preload("res://science_hell/gui/Pause/pause.tscn")

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = true
		var canvas_layer = CanvasLayer.new()
		add_child(canvas_layer)
		var pause = pause_scene.instantiate()
		canvas_layer.add_child(pause)
