extends Node2D

func _ready():
	$AnimationPlayer.play("hover")

func _on_area_2d_body_entered(body):
	if(body.has_method("player")):
		PlayerStats.computer_parts += 1
		PlayerStats.inventory.append("psu")
		queue_free()
		var label = get_node("/root/Debug_or_die/ui/Label")
		label.position.x += 7
		label.text = "
		Power Supply Collected"
		
