extends PointLight2D

@onready var point = self

func _on_lab_area_body_entered(body):
	if(body.has_method("player")):
		point.set_visible(false)

func _on_lab_area_body_exited(body):
	if(body.has_method("player")):
		point.set_visible(true)


func _on_aud_area_body_entered(body):
	if(body.has_method("player")):
		point.set_visible(false)


func _on_aud_area_body_exited(body):
	if(body.has_method("player")):
		point.set_visible(true)


func _on_bathroom_1_area_body_entered(body):
	if(body.has_method("player")):
		point.set_visible(false)


func _on_bathroom_1_area_body_exited(body):
	if(body.has_method("player")):
		point.set_visible(true)
