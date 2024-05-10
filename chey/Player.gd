extends Node

# player item is holding
var inventory: Array = []

func take_item(item: Item):
	inventory.append(item)

# drop item add error handling
func drop_item(item: Item):
	inventory.erase(item)

func get_inventory_list() -> String:
	if inventory.size() == 0:
		return "You don't currently have anything."
		
	var item_string = ""
	for item in inventory:
		item_string += Types.wrap_item_text(item.item_name + " ") #item.item_name + " "
	return "Inventory: " +  item_string
