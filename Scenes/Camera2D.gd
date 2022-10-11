extends Camera2D

onready var target = get_parent().get_node("Player2")
var zoomed = false
var center = Vector2.ZERO



func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode != KEY_ENTER: #basically if any key is pressed, it'll zoom in onto the player
			zoomed = true
		else:
			zoomed = false


#func _process(delta):
#	if zoomed:
#		zoom = Vector2(0.3,0.3)
#		#zoom.move_toward(Vector2(0.3,0.3),0.03)
#		position = target.global_position
#	else:
#		zoom = Vector2(1,1)
#		#zoom.move_toward(Vector2(1,1),0.03)
#		position = center
		
func _process(delta):
	if zoomed == false and GameStats.current_level == 0:
		zoom = Vector2(0.75,0.75)
		#zoom.move_toward(Vector2(1,1),0.03)
		position = target.global_position
	elif zoomed == false and GameStats.current_level == 1:
		zoom = Vector2(0.75,0.75)
		#zoom.move_toward(Vector2(1,1),0.03)
		position = target.global_position
	elif zoomed == false and GameStats.current_level == 2:
		zoom = Vector2(0.9,0.9)
		#zoom.move_toward(Vector2(1,1),0.03)
		position = target.global_position
	elif zoomed == false and GameStats.current_level == 3:
		zoom = Vector2(1,1)
		#zoom.move_toward(Vector2(1,1),0.03)
		position = target.global_position
	else:
		zoom = Vector2(0.3,0.3)
		#zoom.move_toward(Vector2(0.3,0.3),0.03)
		position = target.global_position


