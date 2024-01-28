extends BaseJoke

@onready var teeth = $Teeth

const CLEAN_TEETH = preload("res://Teeth/clean_teeth.png")
const DIRTY_TEETH = preload("res://Teeth/dirty_teeth.png")

var cleanTeethImage: Image = CLEAN_TEETH.get_image()
var currentTeethImage: Image = DIRTY_TEETH.get_image()


func _ready():
	teeth.texture = ImageTexture.create_from_image(currentTeethImage)

func _input(event):
	super._input(event)
	if event is InputEventMouseMotion:
		var copy_rect_size = Vector2i(5, 5)
		var copy_rect_pos = Vector2i(event.position.x - teeth.position.x, event.position.y - teeth.position.y)
		var copy_rect = Rect2i(copy_rect_pos, copy_rect_size)
		currentTeethImage.blit_rect(cleanTeethImage, copy_rect, copy_rect_pos)
		var teethImageTexture = teeth.texture as ImageTexture
		teethImageTexture.update(currentTeethImage)
