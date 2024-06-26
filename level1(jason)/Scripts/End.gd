# Sets global score at the end of the game and allows the user to leave or 
# play again 
extends Node2D


func _ready():
	$GradeNumber.text = Score.grade
	$ScoreNumber.text = str(Score.score)
	$ComboNumber.text = str(Score.combo)
	$GreatNumber.text = str(Score.great)
	$GoodNumber.text = str(Score.good)
	$OkayNumber.text = str(Score.okay)
	$MissedNumber.text = str(Score.missed)
	


func _on_PlayAgain_pressed():
	SceneManager.change_scene('jasonslevel')


func _on_BackToMenu_pressed():
	if Score.grade == "C+" or Score.grade == "B-" or Score.grade == "B" or Score.grade == "B+" or Score.grade == "A-" or Score.grade == "A" or Score.grade == "A+":
		PlayerStats.jason_level_complete = true

	SceneManager.change_scene('sciencehall')
