extends Control

#var last_selected character
var current_sprite = preload("res://science_hell/players/hamilton/ham_headband.png")

var character_sprites = {
	"joey": "res://science_hell/players/joey.png"
}

func _ready():
	Health.set_visibility(false)
	
	
func change_character(sprite: String):
	sprite = sprite.to_lower()
	if character_sprites.has(sprite):
		current_sprite = load(sprite)
	else:
		push_error("Character sprite not found!")



