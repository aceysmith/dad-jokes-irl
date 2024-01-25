extends BaseJoke

@onready var chicken = $Chicken
@onready var punchline = %PunchlineLabel
@onready var instructions = %InstructionsLabel

func _input(event: InputEvent):
	if event.is_action_pressed("ui_right") and punchline.visible == false:
		chicken.position += Vector2(5, 0)
		instructions.visible = false
		if chicken.position.x > 620:
			punchline.visible = true
			exit_button.visible = false
			wrap_up_joke()
