extends Node2D

var score = 0
var combo = 0

var max_combo = 0
var great = 0
var good = 0
var okay = 0
var missed = 0

var bpm = 165

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0
var sec_per_beat = 60.0 / bpm

var spawn_1_beat = 0
var spawn_2_beat = 0
var spawn_3_beat = 1
var spawn_4_beat = 0

var lane = 0
var rand = 0
var note = preload("res://level1(jason)/Scenes/Note.tscn")
var instance


func _ready():
	Health.set_visibility(false)
	$"/root/MusicManager".music_player.stream_paused = true
	randomize()
	$Conductor.play_with_beat_offset(9)


func _input(event):
	if event.is_action("Pause"):
		if get_tree().change_scene_to_file("res://science_hell/src_scene/science_hell.tscn") != OK:
			print ("Error changing scene to Menu")


func _on_Conductor_measure(current_position):
	if current_position == 1:
		_spawn_notes(spawn_1_beat)
	elif current_position == 2:
		_spawn_notes(spawn_2_beat)
	elif current_position == 3:
		_spawn_notes(spawn_3_beat)
	elif current_position == 4:
		_spawn_notes(spawn_4_beat)

func _on_Conductor_beat(current_position):
	song_position_in_beats = current_position
	if song_position_in_beats > 36:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 1
	if song_position_in_beats > 98:
		spawn_1_beat = 2
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats > 132:
		spawn_1_beat = 0
		spawn_2_beat = 2
		spawn_3_beat = 0
		spawn_4_beat = 2
	if song_position_in_beats > 162:
		spawn_1_beat = 2
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 1
	if song_position_in_beats > 194:
		spawn_1_beat = 2
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 2
	if song_position_in_beats > 228:
		spawn_1_beat = 0
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 2
	if song_position_in_beats > 258:
		spawn_1_beat = 1
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 2
	if song_position_in_beats > 304:
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
	#if song_position_in_beats > 316:
		#spawn_1_beat = 0
		#spawn_2_beat = 0
		#spawn_3_beat = 0
		#spawn_4_beat = 0
	#if song_position_in_beats > 388:
		#spawn_1_beat = 1
		#spawn_2_beat = 0
		#spawn_3_beat = 0
		#spawn_4_beat = 0
	#if song_position_in_beats > 396:
		#spawn_1_beat = 0
		#spawn_2_beat = 0
		#spawn_3_beat = 0
		#spawn_4_beat = 0
	if song_position_in_beats > 312:
		Score.set_score(score)
		Score.combo = max_combo
		Score.great = great
		Score.good = good
		Score.okay = okay
		Score.missed = missed
		if get_tree().change_scene_to_file("res://level1(jason)/Scenes/End.tscn") != OK:
			print ("Error changing scene to End")



func _spawn_notes(to_spawn):
	rand = 0
	if to_spawn > 0:
		lane = randi() % 3
		instance = note.instantiate()
		instance.initialize(lane)
		add_child(instance)
	if to_spawn > 1:
		while rand == lane:
			rand = randi() % 3
		lane = rand
		instance = note.instantiate()
		instance.initialize(lane)
		add_child(instance)
		
		


func increment_score(by):
	if by > 0:
		combo += 1
	else:
		combo = 0
	
	if by == 3:
		great += 1
	elif by == 2:
		good += 1
	elif by == 1:
		okay += 1
	else:
		missed += 1
	
	
	score += by * combo
	$Label.text = str(score)
	if combo > 0:
		$Combo.text = str(combo) + " combo!"
		if combo > max_combo:
			max_combo = combo
	else:
		$Combo.text = ""


func reset_combo():
	combo = 0
	$Combo.text = ""


