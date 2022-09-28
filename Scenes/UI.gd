extends Control


func _ready():
	pass

func _process(delta):
	$HBoxContainer/DoubleJumpCounter/Label.text = "x " + GameStats.get_doublejump()
	$HBoxContainer/LifeCounter/Label.text = GameStats.get_lives()
