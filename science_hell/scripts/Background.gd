"""
background.gd - Controls the background color of the main map for different events
"""
class_name Background
extends CanvasModulate

@onready var bg = self

var current_color = "282828"
var dark_shade = "282828"
var slightly_lighter_shade = "404040"
var lighter_shade = "595959"
var even_lighter_shade = "737373"
var very_light_shade = "8c8c8c"
var clear_white = "ffffff"
var lit_area_color = "e4e4e4"

func _ready():
	if PlayerStats.computer_parts <= 0:
		current_color = dark_shade
	elif PlayerStats.computer_parts == 1:
		current_color = slightly_lighter_shade
	elif PlayerStats.computer_parts == 2:
		current_color = lighter_shade
	elif PlayerStats.computer_parts == 3:
		current_color = even_lighter_shade
	elif PlayerStats.computer_parts == 4:
		current_color = very_light_shade
	elif PlayerStats.computer_parts >= 5:
		current_color = clear_white
		check_disable_flashlight()
	
	bg.set_color(current_color)

func _on_lab_area_body_entered(body):
	if body.has_method("player"):
		bg.set_color(clear_white)
		$"../hero/PointLight2D".hide()
		

func _on_lab_area_body_exited(body):
	if body.has_method("player"):
		bg.set_color(current_color)
		check_disable_flashlight()
		

func _on_aud_area_body_entered(body):
	if body.has_method("player"):
		bg.set_color(clear_white)
		$"../hero/PointLight2D".hide()
		
		

func _on_aud_area_body_exited(body):
	if body.has_method("player"):
		bg.set_color(current_color)
		check_disable_flashlight()
		

func _on_bathroom_1_area_body_entered(body):
	if body.has_method("player"):
		bg.set_color(clear_white)
		$"../hero/PointLight2D".hide()
		

func _on_bathroom_1_area_body_exited(body):
	if body.has_method("player"):
		bg.set_color(current_color)
		check_disable_flashlight()
		

func check_disable_flashlight():
	if current_color == clear_white:
		$"../hero/PointLight2D".hide()
	else:
		$"../hero/PointLight2D".show()
		
		
