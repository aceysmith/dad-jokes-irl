extends Node2D

var launched

@onready var ship = $ship
@onready var animated_sprite_2d = $ship/AnimatedSprite2D
@onready var destroy = $destroy

func launch_ship():
	launched = true
	animated_sprite_2d.show()
	animated_sprite_2d.play("blastoff")
	

func destroy_ship():
	if launched: return
	ship.hide()
	destroy.show()
	destroy.play()
	
func _process(delta):
	if !launched: return
	position.y -= delta * 100
	


func _on_destroy_animation_finished():
	
	destroy.hide()
	ship.show()
