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
	SceneManager.change_scene('sciencehall')
