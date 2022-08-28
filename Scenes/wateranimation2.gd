extends Node2D

onready var water = preload("res://Scenes/singlewater.tscn")
var size = 128
var water_count = 1280/128
var move = false

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode != KEY_ENTER: #basically if any key is pressed
			move = true
		else:
			move = false


func _ready():
	for i in range(0,100):
		var w = water.instance()
		add_child(w)
		w.position = Vector2(i * size,0)
	global_position = Vector2(0,720)


func reset_water():
	position.y = GameStats.water_pos


	
func _physics_process(delta):
	if move == true:
		global_position -= Vector2.DOWN* delta * 50



func _on_Area2D_body_entered(body): #THIS DOESN"T WORK AS IT"S ACTUALLY SINGLE WATER AREA...
	if body.is_in_group("Player"):
		print("hi")
		reset_water()
		