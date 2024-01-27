extends Node2D

@onready var jokes_box = %JokesBox
@export var auto_play = false
@onready var you_win_screen = %YouWinScreen
@onready var background_music = %BackgroundMusic


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
			remaining_jokes.append(joke_button.joke_packed_scene)
			joke_button.joke_selected.connect(show_joke)

	if auto_play:
		background_music.play()
		remaining_jokes.shuffle()
		show_next_joke()

func show_next_joke():
	if len(remaining_jokes) > 0:
		show_joke(remaining_jokes.pop_front())
	else:
		you_win_screen.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func show_joke(joke_scene: PackedScene):
	var joke = joke_scene.instantiate() as BaseJoke
	joke.joke_ended.connect(dismiss_joke)
	add_child(joke)
	jokes_box.visible = false

func dismiss_joke(node: Node):
	jokes_box.visible = true
	node.queue_free()
	if auto_play:
		show_next_joke()

func enable_free_play():
	auto_play = false
	jokes_box.visible = true
	you_win_screen.visible = false

func replay_music():
	background_music.play()
