extends Node2D


func open_elevator():
	$AnimationPlayer.play("elevator open")

func delete_npc_reynolds():
	$NpcReyolds.queue_free()
