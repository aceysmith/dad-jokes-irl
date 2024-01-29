extends CharacterBody2D
@export var speed = 1200
@export var jump_speed = -1800
@export var gravity = 4000
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

@onready var animated_sprite_2d = $AnimatedSprite2D
var just_jumped = false
var can_move = true

func _ready():
	animated_sprite_2d.play('WALK')
	
	
	
func _physics_process(delta):
	if !can_move: return
	# Add gravity every frame
	velocity.y += gravity * delta

	# Input affects x axis only
	velocity.x = Input.get_axis("ui_left", "ui_right") * speed

	if velocity.x > 0:
		animated_sprite_2d.flip_h = true
	elif velocity.x < 0:
		animated_sprite_2d.flip_h = false
		
	move_and_slide()

	if is_on_floor() && just_jumped:
		animated_sprite_2d.play('WALK')
		just_jumped = false
	# Only allow jumping when on the ground
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_speed
		animated_sprite_2d.play('jump')
		audio_stream_player_2d.play()
		just_jumped = true
	
func stop_move():
	can_move = false
