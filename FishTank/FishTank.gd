extends BaseJoke

@onready var audio_stream_player_2d = $AudioStreamPlayer2D

@onready var punchline = $punchline
@onready var tank = $Tank
@onready var joke_intro = %JokeIntro

func _ready():
	
	instructions_hidden.connect(func():
		joke_intro.hide()
		tank.enable_movement()
	)
	audio_stream_player_2d.play()

func _on_area_2d_body_entered(body):
	if body is Tank:
		tank.disable_movement()
		punchline.position = tank.position + Vector2(-60, -60)
		punchline.show()
		wrap_up_joke()
