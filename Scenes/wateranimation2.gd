extends Node2D

onready var water = preload("res://Scenes/singlewater.tscn")
var size = 128
var water_count = 1280/128
var move = false
var water_speed = .35

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
	global_position = Vector2(0,888)

func reset_water():
	position.y = GameStats.water_pos

func _physics_process(delta):
	if GameStats.current_level == 0:
		self.global_position.x = GameStats.playerx - 650
		water_speed = 0.35
	elif GameStats.current_level == 1:
		self.global_position.x = GameStats.playerx - 600
		water_speed = 0.4
	elif GameStats.current_level == 2:
		self.global_position.x = GameStats.playerx - 600
		water_speed = 0.425
	elif GameStats.current_level == 3:
		self.global_position.x = GameStats.playerx - 569
		water_speed = 0.45
	elif GameStats.current_level == 4:
		self.global_position.x = GameStats.playerx - 569
		water_speed = 10
	else:
		pass
	if move == true:
		translate(Vector2.UP * water_speed )


func _on_Area2D_body_entered(body): #works.
	if body.is_in_group("Player"):
		reset_water()
		
