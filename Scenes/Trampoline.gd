extends Node2D

var not_pressed = true


func _ready():
	$AnimationPlayer.play("Idle")



func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") and not_pressed == true:
		print("pong")
		$AnimationPlayer.play("Bounce")
		not_pressed = false
		body.velocity.y = -240
		
		yield($AnimationPlayer,"animation_finished")






func _on_Area2D_body_exited(body):
	not_pressed = true
