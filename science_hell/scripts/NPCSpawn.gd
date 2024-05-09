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

func spawn_professors():
	if PlayerStats.chey_level_complete:
		spawn_professor_at_location("cooper", -32, 714)
	
	if PlayerStats.inventory.has("psu"):
		spawn_professor_at_location("reynolds", -938, -554)
		
	if PlayerStats.inventory.has("keyboard"):
		spawn_professor_at_location("ivan", -1175, 76)
		
	if ((PlayerStats.computer_parts > 0 or PlayerStats.chey_level_complete or PlayerStats.jason_level_complete) and (PlayerStats.computer_parts < PlayerStats.num_winning_parts)):
		spawn_professor_at_location("ham", -128, 123)
		await get_tree().create_timer(10).timeout
		PlayerStats.computer_parts = 5
		
		
	
func spawn_professor_at_location(character_sprite: String, x: float, y: float):
	# Instance the NPC scene
	var npc = npc_scene.instantiate()
	
	# Set the NPC's position to the specified coordinates
	npc.global_position = Vector2(x, y)
	
	# Change the NPC's sprite
	var sprite_node = npc.get_node("Sprite2D") # Adjust the node path if necessary
	sprite_node.texture = Characters.set_professor(character_sprite)
	
	# Add the NPC as a child of the current node or any other desired parent node
	add_child(npc)
	


func despawn_npc(character_sprite: String):
	# Find all NPC instances that are children of the current node
	for child in get_children():
		if child.has_node("Sprite2D"):  # Check if the child node has a Sprite2D node
			var sprite_node = child.get_node("Sprite2D")
			if sprite_node.texture == Characters.set_character(character_sprite) or sprite_node.texture == Characters.set_professor(character_sprite):
				# Remove the NPC instance from the scene
				child.queue_free()
				print("Despawned", character_sprite)
				return
	
	print("NPC with sprite", character_sprite, "not found")
