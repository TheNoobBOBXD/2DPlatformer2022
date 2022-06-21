extends Node2D

var found = false

func _ready():
	$AnimatedSprite.hide()
	$AnimatedSprite.stop()
	$Sprite.hide()


func _on_Collect_body_entered(body):
	if found == false:
		print("get coin")
		$Sprite.show()
		translate(Vector2.UP *0.5 )
		$AnimatedSprite.stop()
		$AnimatedSprite.hide()
		$Sprite.hide()
		found = true
	else:
		pass
	


func _on_Enter_body_entered(body):
	if body.is_in_group("Player") and found == false:
		print("enter")
		$AnimatedSprite.show()
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.hide()
		$AnimatedSprite.stop()
