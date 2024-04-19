extends Node

const MAX_WAVES = 4
var current_wave = 1


func next_wave():
	if current_wave <= MAX_WAVES:
		current_wave += 1
		
	return current_wave

