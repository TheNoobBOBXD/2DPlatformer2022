extends Sprite


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		GameStats.current_level = GameStats.current_level +1
		get_tree().change_scene("res://Scenes/Level_" + str(int(get_tree().current_scene.name) +GameStats.current_level) + ".tscn")
		GameStats.current_spawn = null
