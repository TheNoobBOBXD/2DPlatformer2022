extends Node


func _ready():
	pass
	


func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/Level_0.tscn")


func _on_TextureButton2_pressed():	
	pass # Replace with function body.


func _on_TextureButton3_pressed():
	get_tree().quit()
