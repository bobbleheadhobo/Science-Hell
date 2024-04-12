# ScaleManager.gd
extends Node

var original_size = DisplayServer.window_get_size()
var original_scale = ProjectSettings.get_setting("display/window/stretch/scale")

func set_stretch_scale(scale: float) -> void:
	var new_size = original_size / original_scale * scale
	DisplayServer.window_set_size(new_size)

func reset_stretch_scale() -> void:
	DisplayServer.window_set_size(original_size)
