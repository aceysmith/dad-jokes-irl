extends TextureButton

class_name JokeButton

signal joke_selected(scene: PackedScene)

@export var joke_packed_scene: PackedScene

func _on_pressed():
	joke_selected.emit(joke_packed_scene)
