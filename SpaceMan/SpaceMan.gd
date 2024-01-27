extends BaseJoke
const SPRITE_0002 = preload("res://SpaceMan/space-sprites/Sprite-0002.png")
@onready var ship = $Ship
@onready var label = $Label
@onready var timer = $Timer
@onready var punchline = $punchline

func _ready():
	#Input.set_custom_mouse_cursor(SPRITE_0002, Input.CURSOR_ARROW, Vector2())
	pass


func _on_control_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print("Mouse Click/Unclick at: ", event.position)
		timer.start()
		punchline.show()
		ship.show()

		ship.launch_ship()


func _on_timer_timeout():
	wrap_up_joke()


func _on_control_2_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print("explode")


func _on_control_3_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print("explode")


func _on_control_4_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print("explode")
