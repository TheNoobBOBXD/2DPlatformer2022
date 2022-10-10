extends Node


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	

func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/Level_0.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameStats.lives = 3
	GameStats.current_level = 0
	GameStats.coin = 0
	GameStats.reset()




func _on_TextureButton3_pressed():
	get_tree().quit()
