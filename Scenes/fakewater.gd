extends Node2D


var time_elapsed = 0


func _process(delta):
	time_elapsed +=1
	position.y = sin(time_elapsed*delta)*142 + 600


