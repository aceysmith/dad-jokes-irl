extends Node2D

@onready var jokes_box = %JokesBox
var auto_play = false

@onready var main_screen = %MainScreen
@onready var free_play_button = %FreePlayButton

@onready var background_music = %BackgroundMusic

var all_jokes: Array[PackedScene] = []
var remaining_jokes: Array[PackedScene] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# Goes through each joke button and connects their being pressed to showing their scene.
	# This allows us to configure each joke in the editor to be able to add flavor to each button
	for child in jokes_box.get_children():
		var joke_button = child as JokeButton
		if joke_button.joke_packed_scene == null:
			push_error("Scene not fully configured, removing from list")	
			joke_button.queue_free()
		else:
			all_jokes.append(joke_button.joke_packed_scene)
			joke_button.joke_selected.connect(show_joke)

	background_music.play()

func _on_play_button_pressed():
	remaining_jokes = all_jokes.duplicate()
	remaining_jokes.shuffle()

	auto_play = true
	show_next_joke()
	main_screen.hide()

func _on_free_play_button_pressed():
	auto_play = false
	jokes_box.show()
	main_screen.hide()

func show_next_joke():
	if len(remaining_jokes) > 0:
		show_joke(remaining_jokes.pop_front())
	else:
		free_play_button.show()
		main_screen.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func show_joke(joke_scene: PackedScene):
	var joke = joke_scene.instantiate() as BaseJoke
	joke.joke_ended.connect(dismiss_joke)
	add_child(joke)
	jokes_box.hide()

func dismiss_joke(node: Node):
	node.queue_free()
	if auto_play:
		show_next_joke()
	else:
		main_screen.show()

func replay_music():
	background_music.play()
