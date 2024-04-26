extends PanelContainer


@onready var room_name = $MarginContainer/Rows/TitleSection/RoomNameLabel
@onready var room_description = $MarginContainer/Rows/TitleSection/RoomNameLabel

@onready var exit_label = $MarginContainer/Rows/ListArea/ExitLabel
@onready var npc_label = $MarginContainer/Rows/ListArea/NpcLabel
@onready var item_label = $MarginContainer/Rows/ListArea/ItemLabel

#@onready var HeartGUI = preload("res://science_hell/gui/hearts/heart.tscn")
#const MAX_HEALTH = 10
#var current_health = MAX_HEALTH
#var shake = false
#
#var canvas_layer = null
#var hearts_container = null

#func _ready():
	## canvas layer to put hbox in
	#canvas_layer = CanvasLayer.new()
	#add_child(canvas_layer)
	#
	## hbox to put hearts in to
	#hearts_container = HBoxContainer.new()
	#hearts_container.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_LEFT)
	#hearts_container.offset_left = 5  # Adjust this value as needed
	#hearts_container.offset_bottom = -5  # Negative value to go up from bottom
	#hearts_container.set("theme_override_constants/separation", 15)
	#canvas_layer.add_child(hearts_container)
	## add hearts to the screen
	#set_max_hearts(MAX_HEALTH)
	#
	#
#func set_max_hearts(max_hearts : int):
	## divided by two because theres half hearts
	#for i in range(max_hearts/2):
		#var heart = HeartGUI.instantiate()
		#hearts_container.add_child(heart)
		
func handle_room_changed(new_room):
	room_name.text = new_room.room_name
	
	
	#room_description.text = new_room.room_descriptions
	
	exit_label.text = new_room.get_exit_description()
	
	var npc_string = new_room.get_npc_description()
	if npc_string == "":
		npc_label.hide()
	else:
		npc_label.show()
		npc_label.text = npc_string

	var item_string = new_room.get_item_description()
	if item_string == "":
		item_label.hide()
	else:
		item_label.show()
		item_label.text = item_string
		



func handle_room_updated(current_room):
	handle_room_changed(current_room)

	#npc_label.text = new_room.get_npc_description()
	#item_label.text = new_room.get_item_description()
