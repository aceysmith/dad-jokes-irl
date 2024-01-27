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

var user_started = false

func _close_joke():
	joke_ended.emit(self)

func _input(event):
	if user_started:
		return
	if event is InputEventMouseButton or event is InputEventKey:
		user_started = true
		joke_setup_container.visible = false
		instructions_container.visible = false
		instructions_hidden.emit()

func wrap_up_joke():
	if !laugh_timer.is_stopped():
		return

	joke_setup_container.visible = true
	joke_punchline_container.visible = true
	laugh_timer.timeout.connect(_close_joke)
	laugh_timer.start()
