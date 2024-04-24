extends Node

#var last_selected character
var current_sprite = preload("res://science_hell/players/hamilton/ham.png")
var current_sprite_key = "ham"

var professor_sprites = {
	"reynolds": "res://science_hell/players/rey.png"
}

var character_sprites = {
	"joey": "res://science_hell/players/joey.png",
	"bianka": "res://science_hell/players/bianka.png",
	"chey": "res://science_hell/players/chey.png",
	"jason": "res://science_hell/players/jason.png",
	"pat": "res://science_hell/players/pat.png",
	"johnathan": "res://science_hell/players/johnathan.png",
	"chris": "res://science_hell/players/chris.png",
}

func _ready():
	pass
	
func change_character_global(sprite: String):
	sprite = sprite.to_lower()
	if character_sprites.has(sprite):
		var sprite_path = character_sprites[sprite]
		current_sprite = load(sprite_path)
		current_sprite_key = sprite
	else:
		push_error("Character sprite not found for: ", sprite)

func set_character(sprite: String):
	sprite = sprite.to_lower()
	var new_sprite = null
	if character_sprites.has(sprite):
		var sprite_path = character_sprites[sprite]
		new_sprite = load(sprite_path)
	else:
		push_error("Character sprite not found for: ", sprite)
		
	return new_sprite
	
func set_professor(sprite: String):
	sprite = sprite.to_lower()
	var new_sprite = null
	if professor_sprites.has(sprite):
		var sprite_path = professor_sprites[sprite]
		new_sprite = load(sprite_path)
	else:
		push_error("Professor sprite not found for: ", sprite)
		
	return new_sprite
