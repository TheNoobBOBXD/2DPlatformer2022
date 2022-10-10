extends Node2D

var doorclosed = true

func _ready():
	$ButtonAnimationPlayer.play("ButtonUp")
	$AnimationPlayer.play("DoorClosed")
	


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") and doorclosed == true:
		print("open")
		$ButtonAnimationPlayer.play("ButtonDown")
		$AnimationPlayer.play("DoorOpen")
		$AudioStreamPlayer2D.play()
		doorclosed = false
#		yield($AnimationPlayer,"animation_finished")
	if body.is_in_group("Player") and doorclosed == false:
		$ButtonAnimationPlayer.play("ButtonDown")



