class_name Background
extends CanvasModulate

@onready var bg = self

var regular_back = 282828

func _ready():
	bg.set_color("282828")

func _on_lab_area_body_entered(body):
	if(body.has_method("player")):
		bg.set_color("929292")


func _on_lab_area_body_exited(body):
	if(body.has_method("player")):
		bg.set_color("282828")