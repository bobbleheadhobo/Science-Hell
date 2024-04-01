extends Resource
class_name Item # can create item resources now
# add properties using enums
@export var item_name:String = "Item Name"
@export var item_type:Types.ItemTypes = Types.ItemTypes.KEY # uses Types.gd enum

# add more item types later here


# set null to set item to whatever it wants
var use_value = null


	

