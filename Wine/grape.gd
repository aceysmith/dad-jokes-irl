extends Area2D

class_name Grape

@onready var collider = $Collider
@onready var whine_container = %WhineContainer
@onready var whine_label = $WhineContainer/WhineLabel
@onready var grapes = %Grapes
@onready var squished_grapes = %SquishedGrapes
@onready var squish_1 = $squish1
@onready var squish_2 = $squish2

signal grape_stomped()

var move_tween: Tween

func _ready():
	var whines: Array[String] = [
		"Ow!",
		"Oof.",
		"Waaaa",
		"Ouchy",
		"=(",
		"Stahp!",
		"Mommmm",
		"Quit it!"
	]
	whine_label.text = whines[randi() % len(whines)]

func roll(go_right: bool, time_across_screen: float):
	position.x = -100 if go_right else 820
	move_tween = create_tween()
	move_tween.tween_property(self, "position:x", 820 if go_right else -100, time_across_screen)

func _on_area_entered(area):
	if area is Grape:
		return
	
	if randi() % 2:
		squish_1.play()
	else:
		squish_2.play()
	grape_stomped.emit()
	collider.queue_free()
	grapes.hide()
	squished_grapes.show()
	move_tween.stop()
	whine_container.show()
	var timer: Timer = Timer.new()
	timer.timeout.connect(func():
		whine_container.hide()
	)
	add_child(timer)
	timer.start(1)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
