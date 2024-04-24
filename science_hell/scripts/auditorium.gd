extends Node2D

func _on_audit_area_body_entered(body):
	if(body.has_method("player")):
		SceneManager.reveal_scene("AuditRoof", false, 0.3)


func _on_audit_area_body_exited(body):
	if(body.has_method("player")):
		SceneManager.reveal_scene("AuditRoof", true, 0.3)
