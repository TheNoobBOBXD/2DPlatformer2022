extends Node2D
var dir  = 1
var speed = 200
var delta = Vector2()
var move = false

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode != KEY_ENTER: #basically if any key is pressed
			move = true
		else:
			move = false


func _process(delta):
	if move == true:
		translate(Vector2.UP *0.5 )
	else:
		pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		pass
