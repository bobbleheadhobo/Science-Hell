extends Resource # never need to instiate just a data source for scene tree
class_name NPC

# add property instances
@export var npc_name:String = "NPC Name"

@export_multiline var initial_dialog:String
@export_multiline var post_quest_dialog:String


@export var quest_item:Resource

# flags if NPC recieved quest item
var has_recieved_quest_item := false

# exit that gets unlocked with quest_item
# will implement password entry to unlock quest item
var quest_reward = null

