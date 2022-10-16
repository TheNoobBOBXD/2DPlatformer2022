extends Node


func _ready():
	GameStats.game_end()
	$CanvasLayer2/Control/Label.text = GameStats.end_game_time
	print(GameStats.end_game_time)
	$Counter/Label.text = "Total Coins: " + GameStats.get_coin() +  " !!!"
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
