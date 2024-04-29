extends Node

@onready var HeartGUI = preload("res://science_hell/gui/hearts/heart.tscn")
@onready var dead_scene = preload("res://science_hell/scenes/game_over.tscn")

const MAX_HEALTH = 10

var current_health = MAX_HEALTH
var shake = false
var canvas_layer = null
var hearts_container = null
var is_game_over = false

func _ready():
	reset_hearts()
	
func reset_hearts():
	if canvas_layer != null:
		canvas_layer.queue_free()
		
	canvas_layer = CanvasLayer.new()
	add_child(canvas_layer)
	hearts_container = HBoxContainer.new()
	set_main_location()
	canvas_layer.add_child(hearts_container)

	current_health = MAX_HEALTH
	set_max_hearts(MAX_HEALTH)
	
	is_game_over = false

func set_max_hearts(max_hearts : int):
	for i in range(max_hearts/2):
		var heart = HeartGUI.instantiate()
		hearts_container.add_child(heart)

func update_health(new_health : int):
	var heart_points = clamp(new_health, 0, MAX_HEALTH)
	current_health = heart_points

	if heart_points <= 2:
		shake = true
	else:
		shake = false

	var hearts = hearts_container.get_children()

	for heart in hearts:
		var current_heart_state = heart.get_state()

		if shake:
			heart.stop_all_animations()
			heart.play_animation("shake")
		else:
			heart.stop_animation("shake")

		if heart_points >= 2:
			if current_heart_state != heart.Heart_State.FULL:
				heart.update_state(heart.Heart_State.FULL)
				heart.stop_all_animations()
				heart.play_animation("grow")
			heart_points -= 2
		elif heart_points == 1:
			if current_heart_state != heart.Heart_State.HALF:
				heart.update_state(heart.Heart_State.HALF)
				if current_heart_state == heart.Heart_State.EMPTY:
					heart.stop_all_animations()
					heart.play_animation("grow")
			heart_points -= 1
		else:
			if current_heart_state != heart.Heart_State.EMPTY:
				heart.update_state(heart.Heart_State.EMPTY)

	# show game over
	if current_health <= 0 and not is_game_over:
		game_over()

func game_over():
	is_game_over = true
	
	# Pause the current scene
	get_tree().paused = true

	
	var dead = dead_scene.instantiate()
	# Set the process_mode of the game over screen to PROCESS_MODE_ALWAYS
	dead.process_mode = Node.PROCESS_MODE_ALWAYS
	canvas_layer.add_child(dead)
	
	# Connect the button signals using call_deferred
	dead.call_deferred("connect_buttons")


func set_visibility(visible: bool):
	if visible:
		hearts_container.show()
	else:
		hearts_container.hide()

func set_main_location():
	hearts_container.set_anchors_and_offsets_preset(Control.PRESET_TOP_LEFT)
	hearts_container.offset_left = 5
	hearts_container.offset_top = 12
	hearts_container.set("theme_override_constants/separation", 15)
	
func set_chey_location():
	print("hearts", hearts_container.get_children())
	hearts_container.set_anchors_preset(Control.PRESET_CENTER_BOTTOM)
	hearts_container.offset_left = 130
	hearts_container.offset_top = -15
	hearts_container.set("theme_override_constants/separation", 15)
