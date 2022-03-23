extends Node2D


func _ready():
	$AnimationPlayer.play("spiketrigger")




func _on_SpikeTrap_body_entered(body):
	print(body)
	if body.is_in_group("Player"):
		print("L")
		if GameStats.check_reset() == false:
			body.global_position = GameStats.get_spawn().global_position
