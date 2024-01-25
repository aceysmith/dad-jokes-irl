extends Node
class_name MoveComponent


@export var cat: Cat
@export var face_right = false
var speed = 100


func set_rand_dir_and_speed():
	var rng = RandomNumberGenerator.new()
	speed = rng.randf_range(50, 150)
	
	if randi() % 2:
		face_right = false  
		cat.animated_sprite_2d.flip_h = true
	else:
		face_right = true
		cat.animated_sprite_2d.flip_h = false
		
func stop():
	cat.velocity.x = 0
	
func _process(delta):
	if cat.cant_move: return
	if face_right:
		cat.velocity.x += speed * delta
	else:
		cat.velocity.x -= speed * delta
	cat.move_and_slide()

