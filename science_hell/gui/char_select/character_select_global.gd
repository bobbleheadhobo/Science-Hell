extends Node

#var last_selected character
var current_sprite = preload("res://science_hell/players/hamilton/ham.png")

var character_sprites = {
	"joey": "res://science_hell/players/joey.png"
}

func _ready():
	pass
	
func change_character_global(sprite: String):
	sprite = sprite.to_lower()
	if character_sprites.has(sprite):
		var sprite_path = character_sprites[sprite]
		current_sprite = load(sprite_path)
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