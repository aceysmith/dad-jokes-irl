extends BaseJoke
const SPRITE_0002 = preload("res://SpaceMan/space-sprites/Sprite-0002.png")
@onready var ship = $Ship
@onready var label = $Label
@onready var timer = $Timer
@onready var punchline = $punchline
@onready var glove = $glove

func _ready():
	ship.show()

func _process(delta):
	glove.position = get_viewport().get_mouse_position()
	
	
	
func _on_control_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print("Mouse Click/Unclick at: ", event.position)
		timer.start()
		punchline.show()

		ship.launch_ship()


func _on_timer_timeout():
	wrap_up_joke()


func _on_control_2_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print("explode")
		ship.destroy_ship()


func _on_control_3_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print("explode")
		ship.destroy_ship()


func _on_control_4_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print("explode")
		ship.destroy_ship()
