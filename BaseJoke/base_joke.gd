extends Node2D

class_name BaseJoke

signal joke_ended(node: Node)
signal instructions_hidden()

@onready var background_color = %BackgroundColor
@onready var exit_button = %ExitButton
@onready var laugh_timer = %LaughTimer
@onready var joke_setup_container = %JokeSetupContainer
@onready var joke_punchline_container = %JokePunchlineContainer
@onready var instructions_container = %InstructionsContainer
@onready var audio_stream_player = %AudioStreamPlayer

const long_laugh_duration = 8
const short_laugh_duration = 2

var _joke_interaction_started = false
var _joke_ended = false

func _close_joke():
	joke_ended.emit(self)

func _input(event):
	if _joke_interaction_started and !_joke_ended:
		return
	if event.is_pressed() and (event is InputEventMouseButton or event is InputEventKey):
		# After a couple seconds, we let you click through the punch line if you really wanna
		if _joke_ended and (long_laugh_duration - laugh_timer.time_left) > short_laugh_duration:
			laugh_timer.stop()
			_close_joke()
		elif !_joke_interaction_started:
			_joke_interaction_started = true
			joke_setup_container.visible = false
			instructions_container.visible = false
			instructions_hidden.emit()

func wrap_up_joke():
	if _joke_ended:
		return
	_joke_ended = true
	audio_stream_player.play()
	joke_setup_container.visible = true
	joke_punchline_container.visible = true
	laugh_timer.timeout.connect(_close_joke)
	laugh_timer.start(long_laugh_duration)
