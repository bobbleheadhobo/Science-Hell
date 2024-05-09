extends Area2D

var entered = 0 # To process only once

# Called when the node enters the scene tree for the first time.
func _ready():
	set_collision_setting(false)

func _process(delta):
	if PlayerStats.chey_level_complete and entered < 1:
		set_collision_setting(true)
		

func set_collision_setting(tag):
		if tag:
			self.show()
			self.set_deferred("monitoring", true)
			$CollisionShape2D.set_deferred("disabled", false)
			entered += 1
		
		else:
			self.hide()
			self.set_deferred("monitoring", false)
			$CollisionShape2D.set_deferred("disabled", true)

func _on_body_entered(body):
	if body is Player and PlayerStats.jason_level_complete:
		PlayerStats.computer_parts += 1
		$"../ui/Label".text = "
		RAM acquired."
		
		set_collision_setting(false)
		
		await get_tree().create_timer(5.0).timeout
		$"../ui/Label".text = ""
		
		self.queue_free()
