extends CharacterBody2D
class_name Tank
@export var speed = 400
@export var rotation_speed = 1.5
@onready var sprite_2d = $Sprite2D

var rotation_direction = 0

var left = ''
var right = ''
var up = ''
var down = ''
var can_move = false
func disable_movement():
	can_move = false
func enable_movement():
	can_move = true
func _ready():
	# select random keys
	randomize() 
	var key_bindings = ['ui_left', 'ui_right', 'ui_down', 'ui_up', 'other-up', 'other-down', 'other-left', 'other-right']
	key_bindings.shuffle()
	left = key_bindings.pop_front()
	right = key_bindings.pop_front()
	up = key_bindings.pop_front()
	down = key_bindings.pop_front()
	
	
func get_input():
	rotation_direction = Input.get_axis(left, right)
	velocity = transform.x * Input.get_axis(down, up) * speed

func _physics_process(delta):
	if can_move:
		get_input()
		rotation += rotation_direction * rotation_speed * delta
		move_and_slide()
