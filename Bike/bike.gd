extends BaseJoke
@onready var bike_sprite = $BikeSprite

func _process(delta):
	if bike_sprite.rotation_degrees > -90 and bike_sprite.rotation_degrees < 90:
		bike_sprite.rotation = bike_sprite.rotation * 1.01
	else:
		wrap_up_joke()

func _input(event: InputEvent):
	super._input(event)
	if event.is_action_pressed('ui_left'):
		bike_sprite.rotation_degrees -= 1.01
	if event.is_action_pressed('ui_right'):
		bike_sprite.rotation_degrees += 1.02
