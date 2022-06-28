extends Node2D

var up = true
var time_elapsed = 0


func _process(delta):
	time_elapsed +=1
	position.y = sin(time_elapsed*delta)*142 + 600
	print(position.y)
#	if position.y < 800 and position.y > 600 and up == true:
#		translate(Vector2.UP *0.5)
#		print(position.y)
#		print('up')
#	if position.y == 600:
#		up = false
#		translate(Vector2.DOWN *0.5)
#	if position.y > 600 and up == false:
#		translate(Vector2.DOWN *0.5)
#		print(position.y)
#		print('down')

