extends KinematicBody2D

export (int) var speed = 123 
export (int) var jump_speed = -180
export (int) var gravity = 325
export (int) var slide_speed = 400

var velocity = Vector2.ZERO

onready var animator = $AnimationTree.get("parameters/playback")


var dub_jumps = 0
var wall_jumps = 0
var max_num_dub_jumps = 1
var max_num_wall_jumps = 2
export (float) var friction = 10
export (float) var acceleration = 25

enum state {IDLE, RUNNING, PUSHING, ROLLING, JUMP, STARTJUMP, FALL, WALLJUMP, DOUBLEJUMP, ROLL, DEATH}

onready var player_state = state.IDLE
var dir

func _ready():
	pass

func upadate_animation(anim):
	if velocity.x < 0:
		$Sprite.flip_h = true
	elif velocity.x >0:
		$Sprite.flip_h = false
	match(anim):
		state.FALL:
			animator.travel("fall")
		state.IDLE:
			animator.travel("Idle")
		state.JUMP:
			animator.travel("jump")
		state.PUSHING:
			animator.travel("pushing")
		state.RUNNING:
			animator.travel("Running")
#		state.DOUBLEJUMP:
#			animator.travel("roll")
		state.ROLLING:
			animator.travel("Rolling")
		state.DEATH:
			animator.travel("death")


func handle_state(player_state,dir):
	match(player_state):
		state.STARTJUMP:
			velocity.y = jump_speed
		state.DOUBLEJUMP:
			velocity.y = jump_speed * 1.1
		state.ROLLING:
			velocity.x =  dir * acceleration*10
		state.WALLJUMP:
			print("wall jump")
			velocity.y = jump_speed *0.8
			velocity.x = -dir * speed * 2
	pass


func get_input():
	dir = Input.get_action_strength("right") - Input.get_action_strength("left")
	if dir != 0:
		velocity.x = move_toward(velocity.x, dir*speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0 , friction)
	

func _physics_process(delta):
	get_input()
	if velocity == Vector2.ZERO:
		player_state = state.IDLE
		
	
	##NEXT SECTION
	if Input.is_action_just_pressed("jump") and is_on_floor():
		player_state = state.STARTJUMP
		dub_jumps = max_num_dub_jumps
		wall_jumps = max_num_wall_jumps
		print("jump1")
	
	
	elif Input.is_action_just_pressed("jump") and not is_on_floor() and not is_on_wall() and dub_jumps > 0:
			print("dubjump")
			dub_jumps = dub_jumps - 1
			player_state = state.DOUBLEJUMP
			var c = load("res://Scenes/CloufPuff.tscn").instance()
			get_parent().add_child(c)
			c.global_position = global_position
			c.global_position.y +=5
			
			c.emitting = true
	#NEXT BLOCK
	elif Input.is_action_just_pressed("jump") and is_on_wall() and not is_on_floor() and wall_jumps >0:
		print("jump")
		wall_jumps = wall_jumps - 1
		player_state = state.WALLJUMP
		
	#NEXT BLOCK
	elif not is_on_floor() and player_state != state.WALLJUMP:
		if velocity.y < 0:
			player_state = state.JUMP
		if velocity.y > 0:
			player_state = state.FALL

	elif velocity.x != 0:
		if Input.is_action_just_pressed("Down") and is_on_floor():
			player_state = state.ROLLING
			print("roll")
		else:
			print("run")
			player_state = state.RUNNING

	handle_state(player_state,dir)
	upadate_animation(player_state)
#set gravity
	velocity.y += gravity * delta
	velocity  = move_and_slide(velocity, Vector2.UP)
	


func _on_HitBox_area_entered(area):
	if area.is_in_group("Death"):
		player_state = state.DEATH
		if GameStats.check_reset() == false:
			global_position = GameStats.get_spawn().global_position
		print("L") # Replace with function body.
		player_state = state.IDLE 
		velocity.y = 0
		velocity.x = 0
		
	
	

