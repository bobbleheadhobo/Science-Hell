extends Node

@onready var Hearts = $CanvasLayer/Hearts
var max_health = 10

func _ready():
	Hearts.set_max_hearts(max_health)
	test_health_system()


#just for test you can delete this
func test_health_system():
	var test_values = [max_health, 1, max_health/2, max_health - 1, 0, max_health + 1, -1, max_health] # Include edge cases and typical values
	for health in test_values:
		print("Testing health update to: ", health)
		Hearts.update_health(health)
		await get_tree().create_timer(1).timeout
		
	print("All tests completed.")

