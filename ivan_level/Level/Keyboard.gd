extends Area2D

@onready var game_over = null
@onready var level = $".."
var entered = 0 # To process only once

# Called when the node enters the scene tree for the first time.
func _ready():
	set_collision_setting(false)

func _process(delta):
	if game_over and entered < 1:
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
	if body is Player and game_over:
		PlayerStats.computer_parts += 1
		$"../ui/Label".text = "
		Keyboard acquired."
		set_collision_setting(false)
		$"..".acquired = true
