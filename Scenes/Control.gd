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


func _on_Button_pressed():
	get_tree().paused = false
	notpaused = true
	visible = false
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")
	GameStats.lives = 3
	GameStats.current_level = 0
	GameStats.coin = 0


func _on_Button2_pressed():
	get_tree().paused = false
	notpaused = true
	visible = false
