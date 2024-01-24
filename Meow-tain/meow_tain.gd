extends BaseJoke

const CAT = preload("res://Meow-tain/cat.tscn")
@onready var punchline = $punchline
@onready var catgencat = $catgencat

var can_click = true
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1 and can_click:
		var new_cat = CAT.instantiate()
		
		new_cat.position = event.position
		add_child(new_cat)
		can_click = false
		set_cooldown()


func set_cooldown():
	print('set_cooldown')
	catgencat.start()


func _on_area_2d_body_entered(body):
	if body is Cat:
		if body.velocity.y == 0:
			punchline.visible = true
			print("you win!")
			wrap_up_joke()


func _on_catgencat_timeout():
	print('timeout')
	can_click = true
