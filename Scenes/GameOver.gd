extends Node


func _ready():
	pass
	

func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/Level_0.tscn")
	GameStats.lives = 3
	GameStats.current_level = 0
	GameStats.coin = 0





func _on_TextureButton3_pressed():
	get_tree().quit()
