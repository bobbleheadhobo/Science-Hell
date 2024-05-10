extends Node2D

func play_walking_animation(speed):
	$AnimationPlayer.play("walking", -1, speed)

func play_appear_animation(speed):
	$AnimationPlayer.play("appear", -1, speed)

func play_vanish_animation(speed):
	$AnimationPlayer.play("vanish", -1, speed)
	
func play_death_animation(speed):
	$AnimationPlayer.play("die", -1, speed)
