extends Control

func _ready():
	Health.set_visibility(false)

func _on_drop_out_pressed():
	get_tree().paused = false
	Health.reset()
	SceneManager.change_scene("titlescreen")
	$".".queue_free()
	

func _on_retry_pressed():
	get_tree().paused = false
	Health.reset()
	SceneManager.change_scene("sciencehall")
	$".".queue_free()

func connect_buttons():
	$drop_out.pressed.connect(self._on_drop_out_pressed)
	$retry.pressed.connect(self._on_retry_pressed)
	

