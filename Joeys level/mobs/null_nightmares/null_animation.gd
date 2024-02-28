extends Node2D

func play_walking_animation():
	$AnimationPlayer.play("walking")

func play_appear_animation():
	$AnimationPlayer.play("appear")

func play_vanish_animation():
	$AnimationPlayer.play("vanish")
