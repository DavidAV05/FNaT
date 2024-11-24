extends Node2D
class_name Level


@export_group("Cameras view")
@export var camera_view: CameraView = null

@export_range(0, 30, 0.5) var flip_thresh_perc: float = 10
var flip_border = 0
var just_flipped = false

@export_category("Game camera")
@export var camera: GameCamera = null


@onready var viewport_size = get_viewport().get_visible_rect().size


var player_inside_room := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(camera_view != null, "No camera view set")
	assert(camera != null, "No camera set")
	camera_view.hide()
	flip_border = viewport_size[1] * (flip_thresh_perc / 100)

	# Set up signals
	SignalBus.connect("player_entering", _update_player_location)
	SignalBus.connect("player_leaving", _update_player_location)


# Updates whenever player goes into a room
func _update_player_location(_room_name: String) -> void:
	player_inside_room = not player_inside_room


# Handle flipping to cams
func flip_to_cams() -> void:
	var mouse_pos = get_local_mouse_position()
	if mouse_pos[1] > viewport_size[1] - flip_border and not just_flipped:
		if camera_view.view_opened and not player_inside_room:
			SignalBus.emit_signal("hide_cams")
			camera_view.view_opened = false
		elif not player_inside_room:
			camera_view.emit_signal("show_cams")
			camera_view.view_opened = true

		just_flipped = true
	elif mouse_pos[1] < viewport_size[1] - flip_border:
		just_flipped = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	flip_to_cams()
