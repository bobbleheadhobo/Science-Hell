"""
character_select_ui.gd - Handles the UI of the character select screen
"""
extends Control

@onready var CharacterSelect: Dictionary = {
	"joey": $Control1/TextureRect,
	"bianka": $Control2/TextureRect,
	"chey": $Control3/TextureRect,
	"pat": $Control4/TextureRect,
	"jason": $Control5/TextureRect,
	"jonathan": $Control6/TextureRect,
	"chris": $Control7/TextureRect
}

var current_character: String = "joey"

func _ready():
	Health.set_visibility(false)
	$Cursor.global_position = CharacterSelect[current_character].global_position

# Processes the movement of the cursor
func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		var keys = CharacterSelect.keys()
		var current_index = keys.find(current_character)
		
		# Calculate the new index by subtracting 1 and wrapping around to the last character if necessary
		current_index = (current_index - 1 + keys.size()) % keys.size()
		current_character = keys[current_index]
		$Cursor.global_position = CharacterSelect[current_character].global_position

	if Input.is_action_just_pressed("ui_right"):
		var keys = CharacterSelect.keys()
		var current_index = keys.find(current_character)
		
		# Calculate the new index by adding 1 and wrapping around to the last character if necessary
		current_index = (current_index + 1) % keys.size()
		current_character = keys[current_index]
		$Cursor.global_position = CharacterSelect[current_character].global_position

	if Input.is_action_just_pressed("ui_accept"):
		Characters.change_character_global(current_character)
		SceneManager.change_scene("sciencehall")
