extends Node2D

func _ready():
	pass

func _process(delta):
	$CanvasLayer/Control/Label.text = GameStats.get_time() 


func _on_Area2D_body_entered(body):
	pass


