extends Control

var notpaused = true

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if notpaused:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().paused = true
			notpaused = false
			visible = true
		else:
			get_tree().paused = false
			notpaused = true
			visible = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_ResumeButton_pressed():
	get_tree().paused = false
	notpaused = true
	visible = false


func _on_Exit_pressed():
	get_tree().quit()


func _on_NewGame_pressed():
	get_tree().paused = false
	notpaused = true
	visible = false
	get_tree().change_scene("res://Scenes/Level_0.tscn")
	GameStats.lives = 3
	GameStats.current_level = 0
	GameStats.coin = 0
	GameStats.reset()

