extends Camera2D

var target = null
var zoomed = false
var center = Vector2.ZERO


func _ready():
	pass 

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode != KEY_ENTER: #basically if any key is pressed, it'll zoom in onto the player
			target = owner.get_node("Player")
			zoomed = true
		else:
			target = null
			zoomed = false

func _process(delta):
	if zoomed:
		zoom = zoom.move_toward(Vector2(0.3,0.3),0.03)
		position = position.move_toward(target.global_position, 70)
	else:
		zoom = zoom.move_toward(Vector2(1,1),0.03)
		position = position.move_toward(center,70)
