extends BaseJoke
@onready var bike_sprite = $BikeSprite
@onready var sleeping_noises = $SleepingNoises
@onready var thought_cloud = $SleepingNoises/ThoughtCloud

var difficulty: float = 1.001
var begun:bool = false
var bike_fell: bool = false

func _ready():
	instructions_hidden.connect(func():
		begun = true
	)

func _process(delta):
	if !begun or bike_fell:
		return

	if abs(bike_sprite.rotation_degrees) < .001:
		bike_sprite.rotation_degrees += 1

	difficulty += .00001
	if bike_sprite.rotation_degrees > -90 and bike_sprite.rotation_degrees < 90:
		bike_sprite.rotation_degrees = bike_sprite.rotation_degrees * difficulty
	else:
		bike_fell = true
		sleeping_noises.show()
		if bike_sprite.rotation_degrees > 0:
			sleeping_noises.position = Vector2(650, 500)
		else:
			thought_cloud.flip_h = true
			sleeping_noises.position = Vector2(100, 500)
		wrap_up_joke()

func _input(event: InputEvent):
	super._input(event)
	if event.is_action_pressed('ui_left'):
		bike_sprite.rotation_degrees -= 1.01
	if event.is_action_pressed('ui_right'):
		bike_sprite.rotation_degrees += 1.02
