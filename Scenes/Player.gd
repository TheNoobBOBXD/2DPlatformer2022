extends KinematicBody2D

export (int) var speed = 123 
export (int) var jump_speed = -180
export (int) var gravity = 325
export (int) var slide_speed = 400

var velocity = Vector2.ZERO

onready var animator = $AnimationTree.get("parameters/playback")

onready var timer = $Timer 
var cooldown = true 
var dub_jumps = 0
var wall_jumps = 0
var max_num_dub_jumps = 2
var max_num_wall_jumps = 1
#var lives = 3
var emit = true
var death

export (float) var friction = 10
export (float) var acceleration = 25

enum state {IDLE, RUNNING, PUSHING, ROLLING, JUMP, STARTJUMP, FALL, WALLJUMP, DOUBLEJUMP, ROLL, DEATH}

onready var player_state = state.IDLE
var dir

func _ready():
	velocity.y = 0
	velocity.x = 0
	
	
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
			velocity.x =  dir * acceleration*15
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
	GameStats.playerx = self.global_position.x
	if velocity == Vector2.ZERO:
		player_state = state.IDLE
	if is_on_floor():
		GameStats.doublejump = GameStats.doublejump_max
	##NEXT SECTION
	if Input.is_action_just_pressed("jump") and is_on_floor():
		player_state = state.STARTJUMP
		dub_jumps = max_num_dub_jumps
		GameStats.doublejump = GameStats.doublejump_max
		wall_jumps = max_num_wall_jumps
		$JumpSound.play()
	
	elif Input.is_action_just_pressed("jump") and not is_on_floor() and not is_on_wall() and not is_on_ceiling() and dub_jumps > 0:
			dub_jumps = dub_jumps - 1
			GameStats.change_doublejump(-1)
			player_state = state.DOUBLEJUMP
			var c = load("res://Scenes/CloufPuff.tscn").instance()
			get_parent().add_child(c)
			c.global_position = global_position
			c.global_position.y +=5
			$DoubleSound.play()
			c.emitting = true
			

	elif Input.is_action_just_pressed("jump") and is_on_wall() and not is_on_floor() and wall_jumps >0:
		$DoubleSound2.play()
		wall_jumps = wall_jumps - 1
		player_state = state.WALLJUMP
		

	elif not is_on_floor() and player_state != state.WALLJUMP:
		if velocity.y < 0:
			player_state = state.JUMP
		if velocity.y > 0:
			player_state = state.FALL

	elif velocity.x != 0:
		if Input.is_action_just_pressed("Down") and is_on_floor() and cooldown == true:
			player_state = state.ROLLING
			$Slide.play()
			timer.start()
			cooldown = false
			var c = load("res://Scenes/Dashpuff.tscn").instance()
			get_parent().add_child(c)
			c.global_position = global_position
			c.global_position.x +=1
		else:
	
			player_state = state.RUNNING
			
	else:
		player_state = state.IDLE

	handle_state(player_state,dir)
	upadate_animation(player_state)
#set gravity
	velocity.y += gravity * delta
	velocity  = move_and_slide(velocity, Vector2.UP)
	



func _on_HitBox_area_entered(area):
	if area.is_in_group("Death") and GameStats.lives >=1 or GameStats.lives == 0:
		player_state = state.DEATH
		player_state = state.IDLE 
#		lives = lives - 1
#		print(lives)
		print("firstlives")
		GameStats.change_lives(-1)
		print(GameStats.lives)
		$DeathSound.play()
		if GameStats.check_reset() == false:
			global_position = GameStats.get_spawn().global_position
			player_state = state.IDLE 
			velocity.y = 0
			velocity.x = 0
		print("L") # Replace with function body.
		player_state = state.IDLE 
		velocity.y = 0
		velocity.x = 0
		if area.get_parent().has_method("reset_water"): #need to make it so water resetseven if not water kills
			area.get_parent().reset_water()
			print("reset water")
	if GameStats.lives == 0:
		print("game over")
		GameStats.gameover() #could make it so it's either water die water drowning
		#could add gameovercutscene before game over - and if die by spike make bloood


func _on_Timer_timeout():
	cooldown = true
	pass
