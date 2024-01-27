extends BaseJoke

@onready var chicken = $Chicken

var jokeComplete = false

func _input(event: InputEvent):
	super._input(event)
	if (event is InputEventMouseButton or event is InputEventKey) and jokeComplete == false:
		chicken.position += Vector2(10, 0)
		if chicken.position.x > 620:
			jokeComplete = true
			wrap_up_joke()
