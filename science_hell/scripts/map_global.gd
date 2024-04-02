extends Node

var current_scene = "ScienceHell"
var transition_scene = false 

var player_exit_x = -417
var player_exit_y = 41

var player_start_x = -25 
var player_start_y = 55

var game_first_loadin = true

func finish_change_scene(): 
	if transition_scene == true: 
		transition_scene = false
		if current_scene == "ScienceHell": 
			current_scene = "Lab"
		else:
			current_scene = "ScienceHell"


