extends Control


@onready var timer = $Timer


func _on_timer_timeout():
	queue_free()
