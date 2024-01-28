extends BaseJoke
@onready var timeremains = $timeremains
@onready var timeremainlabel = $timeremainlabel
var has_started = false
@onready var empire_height = $"empire height"
@onready var kang_height = $"kang-height"
@onready var kang = $Kang
@onready var empirestate = $empirestate

func _ready():
	timeremainlabel.text = "Time remaining : " + str(timeremains.wait_time)

func _process(delta):
	if Input.get_axis("ui_left", "ui_right") != 0 && !has_started:
		has_started = true
		timeremains.start()
		
	if has_started:
		timeremainlabel.text = "Time remaining : " + str(round(timeremains.time_left))

func _on_timeremains_timeout():
	kang.stop_move()
	kang_height.show()
	kang_height.text = "Kangaroo Jumped: " + str(round(kang.position.y * 10)) + " ft"
	await get_tree().create_timer(4).timeout

	empire_height.show()
	
	await get_tree().create_timer(1).timeout
	wrap_up_joke()
