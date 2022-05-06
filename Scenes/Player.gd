extends KinematicBody2D

export (int) var speed = 123 
export (int) var jump_speed = -180
export (int) var gravity = 325
export (int) var slide_speed = 400

var velocity = Vector2.ZERO

export (float) var friction = 10
export (float) var acceleration = 25

enum state {IDLE, RUNNING, PUSHING, ROLLING, JUMP, STARTJUMP, FALL, WALLJUMP}

onready var player_state = state.IDLE
var dir

func _ready():
	$AnimationPlayer.play("Idle")
	pass

func upadate_animation(anim):
	if velocity.x < 0:
		$Sprite.flip_h = true
	elif velocity.x >0:
		$Sprite.flip_h = false
	match(anim):
		state.FALL:
			$AnimationPlayer.play("fall")
		state.ROLLING:
			$AnimationPlayer.play("roll")
		state.IDLE:
			$AnimationPlayer.play("Idle")
		state.JUMP:
			$AnimationPlayer.play("jump")
		state.PUSHING:
			$AnimationPlayer.play("pushing")
		state.RUNNING:
			$AnimationPlayer.play("Running")
	pass

func handle_state(player_state,dir):
	match(player_state):
		state.STARTJUMP:
			velocity.y = jump_speed
		state.WALLJUMP:
			print("wall jum[]")
			velocity.y = jump_speed /2 
			velocity.x = -dir * speed *3
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
	if Input.is_action_just_pressed("jump") and is_on_floor():
		player_state = state.STARTJUMP
	elif velocity.x != 0:
		player_state = state.RUNNING
	
	if Input.is_action_just_pressed("jump") and is_on_wall() and not is_on_floor():
		print("jump")
		player_state = state.WALLJUMP
	
	if not is_on_floor() and player_state != state.WALLJUMP:
		if velocity.y < 0:
			player_state = state.JUMP
		if velocity.y > 0:
			player_state = state.FALL

	handle_state(player_state,dir)
	upadate_animation(player_state)
#set gravity
	velocity.y += gravity * delta
	velocity  = move_and_slide(velocity, Vector2.UP)
	


func _on_HitBox_area_entered(area):
	if area.is_in_group("Death"):
		if GameStats.check_reset() == false:
			global_position = GameStats.get_spawn().global_position
		print("L") # Replace with function body.
#		
#
	
