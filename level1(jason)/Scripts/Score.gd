# code to determine grade based on performance of player
extends Node2D


var score = 0
var combo = 0
var great = 0
var good = 0
var okay = 0
var missed = 0
var grade = "NA"

# sets global grade based on how the player did 
func set_score(new):
	score = new
	if score > 115000:
		grade = "A+"
	elif score > 100000:
		grade = "A"
	elif score > 85000:
		grade = "A-"
	elif score > 70000:
		grade = "B+"
	elif score > 55000:
		grade = "B"
	elif score > 40000:
		grade = "B-"
	elif score > 30000:
		grade = "C+"
	elif score > 20000:
		grade = "C"
	elif score > 15000:
		grade = "C-"
	elif score > 10000:
		grade = "D+"
	elif score > 7500:
		grade = "D"
	elif score > 5000:
		grade = "D-"
	else:
		grade = "F"
		
