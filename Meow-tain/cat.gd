extends CharacterBody2D
class_name Cat
@onready var idle = $States/Idle
@onready var walk = $States/Walk
@onready var states = $States
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite_2d = $AnimatedSprite2D
var cant_move = false
var is_touching_cat = false
var can_win = false
signal won()

func _process(delta):
	if cant_move: return
	velocity.y += gravity * delta
	move_and_slide()

func stop_moving():
	print("stop")
	cant_move = true
	
func _ready() -> void:
	add_to_group("cats")

	randomize() 

	if randi() % 2:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false
		
	for state in states.get_children():
		state = state as StateComponent
		state.disable()

	idle.state_finished.connect(func():
		switch_to_random_state()
	)

	walk.state_finished.connect(func():
		for child in walk.get_children():
			if child is MoveComponent:
				child.stop()
		switch_to_random_state()
	)

	idle.enable()


		
func switch_to_random_state():
	var state = states.get_children()[randi() % states.get_children().size()]
	for child in state.get_children():
		if child is AnimationManager:
			child.set_animation()
			
	if state.state_type == TimedStateComponent.StateType.WALK:
		for child in state.get_children():
			if child is MoveComponent:
				child.set_rand_dir_and_speed()
		#pick direction
		
	state.enable()	
	
		
#func _process(delta):
	#move_and_slide()


func _on_catcol_body_entered(body):
	print('body : ' + str(body))
	if body is Cat:
		print("touching cat")
		cant_move = true
		is_touching_cat = true
		


func _on_catcol_area_entered(area):
	print('CatCollision')
	if area is CatCollision:
		print("touching cat")
		cant_move = true
		is_touching_cat = true
	


func _on_timer_timeout():
	can_win = true
