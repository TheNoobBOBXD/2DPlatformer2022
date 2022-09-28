extends Node

onready var game_start_time = OS.get_ticks_msec()
var current_spawn = null
var current_level = 0
var timerun = false
var water_pos = 0
var playerx
var pause = false

var coin = 0
var lives = 3
var lives_max = 3
var doublejump = 0
var doublejump_max = 2

func change_lives(amount):
	lives += amount
	lives = clamp(lives,0,lives_max)

func change_doublejump(amount):
	doublejump += amount
	doublejump = clamp(doublejump,0,doublejump_max)

func change_coin(amount):
	coin += amount


func get_coin():
	return str(coin)

func get_lives():
	return str(lives)

func get_doublejump():
	return str(doublejump)


func reset():
	current_spawn = null
	get_tree().reload_current_scene()
	game_start_time = OS.get_ticks_msec()
	timerun = false
	print("stopit")
	print(current_level)


func gameover():
	get_tree().change_scene("res://Scenes/GameOver.tscn")
	timerun = false
	

func waterpos(pos, water_y):
	water_pos = max(water_y, pos +250)
	
	
func check_reset(): ##might remove this
	if current_spawn == null:
		reset()
	else:
		return false

func set_spawn(spawn):
	current_spawn = spawn

func get_spawn():
	return current_spawn 


func _input(event):
	if event is InputEventKey and event.pressed and timerun == false:
		if event.scancode != KEY_ENTER: 
			timerun = true
			game_start_time = OS.get_ticks_msec()
		else:
			timerun = false

func get_time():
	if timerun == true:
		var current_time = OS.get_ticks_msec() - game_start_time
		var minutes = current_time/1000/60
		var seconds = current_time/1000%60
		var msec = current_time%1000/10
		if minutes < 10:
			minutes = "0"+str(minutes)
		if seconds <10:
			seconds = "0"+str(seconds)
		if msec <10:
			if msec == 0:
				msec = "00"
			else:
				msec = "0" + str(msec)
		return str(minutes) + ":" + str(seconds)+ "." +str(msec)
	else:
		return str("00:00:00")
