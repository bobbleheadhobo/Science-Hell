"""
weapon.gd - Handles Excaliboard mechanics
"""
extends Sprite2D

var can_fire = true
var bullets_fired = 0
var bullet = preload("res://ivan_level/Character/bullet.tscn")

func _ready():
	set_as_top_level(true)

# Processes where Excaliboard aims and shoots
func _physics_process(delta):
	position.x = lerp(position.x, get_parent().position.x, 0.5)
	position.y = lerp(position.y, get_parent().position.y + 10, 0.5)
	
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	
	# When Excaliboard is fired
	if Input.is_action_just_pressed("fire") and can_fire:
		bullets_fired += 1
		$"../ui/Label".text = "Ammo: " + str(10 - bullets_fired) + "/10"
		var bullet_instance = bullet.instantiate()
		bullet_instance.rotation = rotation
		bullet_instance.global_position = $Marker2D.global_position
		get_parent().add_child(bullet_instance)
		
		# Gun cooldown...
		if bullets_fired >= 10:
			can_fire = false
			$"../ui/Label".text = "Reloading..."
			await get_tree().create_timer(2).timeout
			$"../ui/Label".text = "" 
			bullets_fired = 0
			can_fire = true
