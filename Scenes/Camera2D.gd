extends Camera2D

onready var target = owner.get_node("Player")
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
		zoom = Vector2(0.3,0.3)
#		zoom.move_toward(Vector2(0.3,0.3),0.03)
		position = position.move_toward(target.global_position, 70)
	else:
		zoom = Vector2(1,1)
#		zoom.move_toward(Vector2(1,1),0.03)
		position = position.move_toward(center,70)
