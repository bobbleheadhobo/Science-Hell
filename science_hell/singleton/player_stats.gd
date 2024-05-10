"""
player_stats.gd - Keeps track of how many computer parts the player has collected
"""
extends Node

@onready var computer_parts = 0
@onready var chey_level_complete = false
@onready var jason_level_complete = false

# Game is won when player collects them all
func _process(delta):
	if computer_parts >= 5:
		#Game won
		pass
