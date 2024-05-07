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
	if get_tree().change_scene_to_file("res://level1(jason)/Scenes/Game.tscn") != OK:
			print ("Error changing scene to Game")


func _on_BackToMenu_pressed():
	#if get_tree().change_scene_to_file("res://science_hell/src_scene/science_hell.tscn") != OK:
			#print ("Error changing scene to Menu")
	SceneManager.change_scene('sciencehall')
