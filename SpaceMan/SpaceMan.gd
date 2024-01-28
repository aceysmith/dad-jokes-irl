extends BaseJoke
const SPRITE_0002 = preload("res://SpaceMan/space-sprites/Sprite-0002.png")
@onready var ship = $Ship
@onready var timer = $Timer
@onready var glove = $glove
@onready var explode_sound = $"explode-sound"
@onready var launch = $launch
@onready var punchline = $punchline

func _ready():
	ship.show()

func _process(_delta):
	glove.position = get_viewport().get_mouse_position()
	
	
	
func _on_control_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print("Mouse Click/Unclick at: ", event.position)
		timer.start()
		launch.play()
		ship.launch_ship()


func _on_timer_timeout():
	punchline.play()
	wrap_up_joke()

func explode():
	ship.destroy_ship()
	explode_sound.play()
	
func _on_control_2_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print("explode")
		explode()


func _on_control_3_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print("explode")
		explode()


func _on_control_4_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print("explode")
		explode()
