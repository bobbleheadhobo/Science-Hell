# Code to spawn falling notes and get rid of them when they are hit 
extends Node2D

const TARGET_Y = 164
const SPAWN_Y = -16
const DIST_TO_TARGET = TARGET_Y - SPAWN_Y

const LEFT_LANE_SPAWN = Vector2(120, SPAWN_Y)
const CENTRE_LANE_SPAWN = Vector2(160, SPAWN_Y)
const RIGHT_LANE_SPAWN = Vector2(200, SPAWN_Y)

var speed = 0
var hit = false

func _ready():
	pass

# how fast notes will fall
func _physics_process(delta):
	if !hit:
		position.y += speed * delta
		if position.y > 200:
			queue_free()
			get_parent().reset_combo()
	else:
		$Node2D.position.y -= speed * delta

# creates 1 note per lane 
func initialize(lane):
	if lane == 0:
		$AnimatedSprite2D.frame = 1
		position = LEFT_LANE_SPAWN
	elif lane == 1:
		$AnimatedSprite2D.frame = 3
		position = CENTRE_LANE_SPAWN
	elif lane == 2:
		$AnimatedSprite2D.frame = 2
		position = RIGHT_LANE_SPAWN
		
	else:
		printerr("Invalid lane set for note: " + str(lane))
		return
	
	speed = DIST_TO_TARGET / 2.0

# note dissapears and shows what accuracy the user hit it at 
func destroy(score):
	$CPUParticles2D.emitting = true
	$AnimatedSprite2D.visible = false
	$Timer.start()
	hit = true
	if score == 3:
		$Node2D/Label.text = "GREAT"
		$Node2D/Label.modulate = Color("f6d6bd")
	elif score == 2:
		$Node2D/Label.text = "GOOD"
		$Node2D/Label.modulate = Color("c3a38a")
	elif score == 1:
		$Node2D/Label.text = "OKAY"
		$Node2D/Label.modulate = Color("997577")


func _on_Timer_timeout():
	queue_free()


func _on_label_ready():
	pass # Replace with function body.
