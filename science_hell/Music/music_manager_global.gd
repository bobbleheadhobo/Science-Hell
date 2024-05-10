# global script to control the music in each scene for the entire game

extends Node

var songs = {
	"menu": "res://science_hell/Music/Heaven or Hell (Menu DEMO).wav",
	"ivan": "res://science_hell/Music/Battle at Chuga Jung castle.wav",
	"reynolds": "res://science_hell/Music/Input Output.wav",
	"chey": "res://science_hell/Music/Roulette (with keycard).wav",
	"spooky": "res://science_hell/Music/Ambiance_Loop.wav",
	"sciencehall": "res://science_hell/Music/Ambiance.Loop (updated).wav",
	"credits": "res://science_hell/Music/Chorale for a Graduate.wav"
}

var current_song = ""
var music_player = AudioStreamPlayer.new()

func _ready():
	add_child(music_player)
	music_player.connect("finished", MusicManager._on_music_finished)

func play_song(song_name, fade_duration = 1.0):
	if song_name in songs:
		var song_path = songs[song_name]
		
		# Set the new song and play it
		current_song = song_path
		music_player.stream = load(song_path)
		music_player.play()
		
		# Fade in the new song
		music_player.volume_db = -80  # Start with a low volume
		var tween = create_tween()
		tween.tween_property(music_player, "volume_db", 0, fade_duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		tween.connect("finished", tween.kill)
	else:
		print("Song not found: ", song_name)

func stop_music(fade_duration = 1.0):
	if music_player.playing:
		var tween = create_tween()
		tween.tween_property(music_player, "volume_db", -80, fade_duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		tween.connect("finished", music_player.stop)
		tween.connect("finished", tween.kill)
		
func _on_music_finished():
	if current_song != "":
		# Pause the stream and start playing from the beginning
		music_player.stream_paused = true
		music_player.play(0)
