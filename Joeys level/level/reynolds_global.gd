extends Node

var current_wave = 1

func next_wave():
	if current_wave < 4:
		current_wave += 1

func reset():
	current_wave = 1
