extends Node2D

@onready var jokes_box = $JokesBox

var current_joke: BaseJoke

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
			joke_button.joke_selected.connect(show_joke)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func show_joke(joke_scene: PackedScene):
	var joke = joke_scene.instantiate() as BaseJoke
	current_joke = joke
	joke.joke_ended.connect(dismiss_joke)
	add_child(joke)
	jokes_box.visible = false

func dismiss_joke(node: Node):
	jokes_box.visible = true
	node.queue_free()
