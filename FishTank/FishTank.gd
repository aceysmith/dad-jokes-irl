extends BaseJoke


@onready var punchline = $punchline
@onready var tank = $Tank



func _on_timer_timeout():
	punchline.hide()
	tank.enable_movement()





func _on_area_2d_body_entered(body):
	if body is Tank:
		print("you win")
		wrap_up_joke()
