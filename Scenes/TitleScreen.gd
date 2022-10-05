extends Node


func _ready():
	pass
	


func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/Level_0.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_TextureButton2_pressed():	
	pass # Replace with function body.


func _on_TextureButton3_pressed():
	get_tree().quit()
	print("QUIT")
