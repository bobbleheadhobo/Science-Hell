extends Resource # never need to instiate just a data source for scene tree
class_name NPC

# add property instances
@export var npc_name:String = "NPC Name"

@export_multiline var initial_dialog:String

@export_multiline var post_quest_dialog:String
