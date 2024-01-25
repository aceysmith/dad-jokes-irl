extends Node
class_name AnimationManager

@export var animated_sprite : AnimatedSprite2D
@export var animation_name : String


func set_animation():
	print("animation_name + : " + str(animation_name))
	animated_sprite.play(animation_name)
	
