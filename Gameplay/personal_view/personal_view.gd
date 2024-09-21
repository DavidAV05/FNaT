extends Node2D

@export var LEFT_BORDER := 0 
@export var RIGHT_BORDER := 1536
@export_range(0, 20) var CAMERA_PAN_SPEED := 5.0
@export_range(0, 50) var CAMERA_PAN_THRESH := 10.0

@onready var CAM: Camera2D = $Camera
@onready var VIEWPORT: Viewport = null

var MOUSE_AT_LEFT = false
var MOUSE_AT_RIGHT = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CAM.limit_left = LEFT_BORDER
	CAM.limit_right = RIGHT_BORDER
	VIEWPORT = get_viewport()
	CAMERA_PAN_SPEED = RIGHT_BORDER / (1000 / CAMERA_PAN_SPEED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Get size of visible viewport:
	var visible_viewport_size = VIEWPORT.get_visible_rect().size
	var visible_x_axis_len = visible_viewport_size[0]
	
	# Define when camera pans
	var border_thresh = visible_x_axis_len * (CAMERA_PAN_THRESH / 100)
	
	var cam_top_left_pos = CAM.position - (VIEWPORT.get_visible_rect().size / 2)
	print(cam_top_left_pos)
	
	var mouse_pos = VIEWPORT.get_mouse_position()
	if mouse_pos[0] < border_thresh:
		if cam_top_left_pos[0] > LEFT_BORDER:
			CAM.position[0] -= CAMERA_PAN_SPEED
	
	if mouse_pos[0] > visible_x_axis_len - border_thresh:
		if cam_top_left_pos[0] + visible_x_axis_len < RIGHT_BORDER:
			CAM.position[0] += CAMERA_PAN_SPEED
