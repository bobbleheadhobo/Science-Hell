extends Node


enum ItemTypes{
	#add items here (have to be capped)
	KEY,
	QUEST_ITEM,
}


# Colors for font
const COLOR_NPC = Color("#000080")
const COLOR_ITEM = Color("#800080")
const COLOR_SPEECH = Color("#00b32d")
const COLOR_LOCATION = Color("#228B22")
const COLOR_SYSTEM = Color("#8B0000")



# helper functions
func wrap_npc_text(text: String) -> String:
	return "[color=#%s]%s[/color]" % [COLOR_NPC.to_html(), text]


func wrap_item_text(text: String) -> String:
	return "[color=#%s]%s[/color]" % [COLOR_ITEM.to_html(), text]


func wrap_speech_text(text: String) -> String:
	return "[color=#%s]%s[/color]" % [COLOR_SPEECH.to_html(), text]


func wrap_location_text(text: String) -> String:
	return "[color=#%s]%s[/color]" % [COLOR_LOCATION.to_html(), text]


func wrap_system_text(text: String) -> String:
	return "[color=#%s]%s[/color]" % [COLOR_SYSTEM.to_html(), text]
