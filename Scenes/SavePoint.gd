extends Area2D

onready var checkpoint_pos =  global_position.y
onready var water = get_parent().get_node("Water")
func _ready():
	$AnimationPlayer.play("checkpoint")


func _process(delta):
	if GameStats.get_spawn() != self:
		$AnimationPlayer.play("checkpoint")
#	if GameStats.water_get_spawn() != self:
		#$AnimationPlayer.play("checkpoint")
	



func _on_SavePoint_body_entered(body):
	if body.is_in_group("Player"):
		GameStats.set_spawn(self)
		$AnimationPlayer.play("saved")
		print("nerd")
		GameStats.waterpos(checkpoint_pos, water.global_position.y)
#		if water.global_position.y <= GameStats.water_pos:
#			water.reset_water()
		
		
 
