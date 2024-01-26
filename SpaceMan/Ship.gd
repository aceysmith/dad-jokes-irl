extends Node2D

var launched
@onready var animated_sprite_2d = $AnimatedSprite2D

func launch_ship():
	launched = true
	animated_sprite_2d.show()
	animated_sprite_2d.play("blastoff")
	

	
	
func _process(delta):
	if !launched: return
	position.y -= delta * 100
	
	
	
