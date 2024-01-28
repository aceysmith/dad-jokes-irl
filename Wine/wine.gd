extends BaseJoke

var is_stomping = false
var default_foot_position = 300
var stomped_foot_position = 650
@onready var grape_spawner_timer = $GrapeSpawnerTimer

var grapes_left = 10

const GRAPE = preload("res://Wine/grape.tscn")

@onready var foot = %Foot

func _ready():
	foot.position.y = default_foot_position

func _input(event):
	super._input(event)
	if grapes_left <= 0:
		return
	if event is InputEventMouseMotion:
		var mouseMotion = event as InputEventMouseMotion
		foot.position.x = mouseMotion.position.x
	
	if !is_stomping and event is InputEventMouseButton:
		var mouseButton = event as InputEventMouseButton
		if mouseButton.is_pressed():
			is_stomping = true
			var tween = foot.create_tween()
			tween.tween_property(foot, "position:y", stomped_foot_position, 0.3)
			tween.tween_property(foot, "position:y", default_foot_position, 1.0)
			tween.tween_callback(func():
				is_stomping = false
			)

func _on_grape_spawner_timer_timeout():
	var grape = GRAPE.instantiate() as Grape
	grape.position = Vector2(0, stomped_foot_position)
	grape.grape_stomped.connect(grape_stomped)
	add_child(grape)
	grape.roll(true if randi() % 2 == 0 else false, randf_range(0.5, 2.5))

func grape_stomped():
	grapes_left -= 1
	if grapes_left <= 0:
		grape_spawner_timer.stop()
		wrap_up_joke()
