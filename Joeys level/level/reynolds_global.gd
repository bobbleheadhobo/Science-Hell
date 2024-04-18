extends Node

var current_wave = 1

func next_wave():
	if current_wave < 5:
		current_wave += 1
		
	return current_wave

