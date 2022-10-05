extends Sprite

var cooldown = true
onready var timer = $Timer 

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		timer.start()
		cooldown = false
		if cooldown == false:
			GameStats.current_level = GameStats.current_level +1
			get_tree().change_scene("res://Scenes/Level_" + str(int(get_tree().current_scene.name) +GameStats.current_level) + ".tscn")
			GameStats.current_spawn = null
			print(GameStats.current_level)
			print("nextlevel")
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



func _on_Timer_timeout():
	cooldown = true
	pass 
