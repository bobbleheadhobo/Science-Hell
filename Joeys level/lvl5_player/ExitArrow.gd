extends Marker2D
var psu = null

@onready var exit = get_node("/root/Debug_or_die/ReynoldsSpawnPoint")
@onready var inventory = PlayerStats.inventory

func _process(delta):
	if Rey.game_over:
		if inventory.find("psu") == -1:
			look_at(psu.global_position)
		else:
			look_at(exit.global_position)

func get_psu():
	psu = get_node("/root/Debug_or_die/Powersupply")
