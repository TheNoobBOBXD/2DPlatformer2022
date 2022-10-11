extends Control


func _ready():
	$HBoxContainer/LifeCounter/Label/TextureRect1.show()
	$HBoxContainer/LifeCounter/Label/TextureRect2.show()
	$HBoxContainer/LifeCounter/Label/TextureRect3.show()

func _process(delta):
	$HBoxContainer/DoubleJumpCounter/Label.text = "x " + GameStats.get_doublejump()
	$HBoxContainer/Counter/Label.text = "x " + GameStats.get_coin()
	$HBoxContainer/LifeCounter/Label.text = GameStats.get_lives()
	if GameStats.lives == 2:
		$HBoxContainer/LifeCounter/Label/TextureRect3.hide()
	elif GameStats.lives == 1:
		$HBoxContainer/LifeCounter/Label/TextureRect2.hide()
		$HBoxContainer/LifeCounter/Label/TextureRect3.hide()
	
	if GameStats.coin == 1:
		$HBoxContainer/Counter/Label/TextureRect.show()
		

