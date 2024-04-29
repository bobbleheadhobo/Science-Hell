extends Node

const MAX_WAVES = 4
var current_wave = 1
var game_over = false


func next_wave():
	if current_wave <= MAX_WAVES:
		current_wave += 1
		
	return current_wave

func reset():
	current_wave = 1
