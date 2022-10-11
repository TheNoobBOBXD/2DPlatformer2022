extends Node2D

var found = false

func _ready():
	$Sprite2.show()
	$Sprite2/AnimationPlayer.play("CoinTurn")
	$Sprite3.hide()
	

func _on_Collect_body_entered(_body):
	if found == false:
		$AudioStreamPlayer.play()
		$Sprite2.hide()
		$Sprite3/AnimationPlayer.play("CoinPickup")
		print("get coin")
		found = true
		GameStats.change_coin(+1)
	else:
		pass
	


