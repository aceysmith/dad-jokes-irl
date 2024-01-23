extends Node2D

class_name BaseJoke

signal joke_ended(node: Node)

@onready var background_color = $BackgroundColor
@onready var exit_button = $ExitButton
@onready var laugh_timer = $LaughTimer

func _close_joke():
	joke_ended.emit(self)
	
func wrap_up_joke():
	if laugh_timer.is_stopped():
		laugh_timer.timeout.connect(_close_joke)
		laugh_timer.start()
