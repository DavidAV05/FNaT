extends Node2D
class_name Level


@export_group("Game view")
@export var camera_view: CameraView = null

@export_range(0, 30, 0.5) var flip_thresh_perc: float = 10
var flip_border = 0
var just_flipped = false

@onready var viewport_size = get_viewport().get_visible_rect().size


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(camera_view != null)
	camera_view.hide()
	flip_border = viewport_size[1] * (flip_thresh_perc / 100)


# Handle flipping to cams
func flip_to_cams() -> void:
	var mouse_pos = get_local_mouse_position()
	if mouse_pos[1] > viewport_size[1] - flip_border and not just_flipped:
		print("Flipping")
		if camera_view.VIEW_OPENED:
			SignalBus.emit_signal("hide_cams")
			camera_view.VIEW_OPENED = false
		else:
			camera_view.emit_signal("show_cams")
			camera_view.VIEW_OPENED = true

		just_flipped = true
	elif mouse_pos[1] < viewport_size[1] - flip_border:
		just_flipped = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	flip_to_cams()
