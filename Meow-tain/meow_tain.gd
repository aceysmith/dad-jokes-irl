extends BaseJoke

const CAT = preload("res://Meow-tain/cat.tscn")
@onready var catgencat = $catgencat
@onready var cat_chorus = $CatChorus

var can_click = true
var stop_spawn
func _ready():
	instructions_hidden.connect(func():
		stop_spawn = false
		set_cooldown()
	)

func set_cooldown():
	print('set_cooldown')
	catgencat.start()


func _on_area_2d_body_entered(body):
	if body is Cat:
		if body.velocity.y == 0 and body.can_win:
			stop_spawn = true
			get_tree().call_group("cats", "stop_moving")
			cat_chorus.play()
			wrap_up_joke()


func _on_catgencat_timeout():
	if stop_spawn: return
	var new_cat = CAT.instantiate()
	
	new_cat.position = get_viewport().get_mouse_position()
	add_child(new_cat)
	
	can_click = false
	set_cooldown()
	
