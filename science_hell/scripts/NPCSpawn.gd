extends Path2D

var npc_scene = preload("res://science_hell/NPC/NPC.tscn")

func spawn_npc(character_sprite: String):
	# Generate a random offset along the path (between 0 and 1)
	var random_offset = randf()

	# Get the random position on the path based on the offset
	var random_position = curve.sample_baked(curve.get_baked_length() * random_offset)

	# Instance the NPC scene
	var npc = npc_scene.instantiate()

	# Set the NPC's position to the random position on the path
	npc.global_position = random_position
	
	# Change the NPC's sprite
	var sprite_node = npc.get_node("Sprite2D")  # Adjust the node path if necessary
	sprite_node.texture = Characters.set_character(character_sprite)

	# Add the NPC as a child of the Path2D or any other desired parent node
	add_child(npc)


func spawn_unselected_players():
	var characters = Characters.character_sprites
	if characters.has(Characters.current_sprite_key):
		characters.erase(Characters.current_sprite_key)
	
		
	for key in characters.keys():
		spawn_npc(key)
