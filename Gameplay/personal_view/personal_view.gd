extends Node2D

@export var LEFT_BORDER := 0 
@export var RIGHT_BORDER := 1536
@export_range(0, 20) var CAMERA_PAN_SPEED := 5.0
@export_range(0, 50) var CAMERA_PAN_THRESH := 10.0
@export_range(0, 50) var CAMERA_VIEW_THRESH := 10.0

@onready var CAM: Camera2D = $Camera
@onready var VIEWPORT: Viewport = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(Viewport != null)
	CAM.limit_left = LEFT_BORDER
	CAM.limit_right = RIGHT_BORDER
	CAMERA_PAN_SPEED = RIGHT_BORDER / (1000 / CAMERA_PAN_SPEED)
	
	VIEWPORT = get_viewport()


func _handle_cam_pan() -> void:
	# Get size of visible viewport:
	var visible_viewport_size = VIEWPORT.get_visible_rect().size
	var visible_x_axis_len = visible_viewport_size[0]
		# Define when camera pans
	var border_thresh = visible_x_axis_len * (CAMERA_PAN_THRESH / 100)

	var middle_of_screen = (VIEWPORT.get_visible_rect().size / 2)
	var cam_top_left_pos = CAM.position - middle_of_screen
	#print(cam_top_left_pos)

	var mouse_pos = VIEWPORT.get_mouse_position()
	if mouse_pos[0] < border_thresh:
		# Check if after moving camera still right of LEFT_BORDER
		if cam_top_left_pos[0] - CAMERA_PAN_SPEED > LEFT_BORDER:
			CAM.position[0] -= CAMERA_PAN_SPEED
		# If after moving left of border, set camera at border
		elif cam_top_left_pos[0] > LEFT_BORDER:
			CAM.position[0] = LEFT_BORDER + middle_of_screen[0]
	
	if mouse_pos[0] > visible_x_axis_len - border_thresh:
		# Check if after moving camera still left of RIGHT_BORDER
		if cam_top_left_pos[0] + visible_x_axis_len + CAMERA_PAN_SPEED < RIGHT_BORDER:
			CAM.position[0] += CAMERA_PAN_SPEED
		# If after moving right of border, set camera at border
		elif cam_top_left_pos[0] + visible_x_axis_len < RIGHT_BORDER:
			CAM.position[0] = RIGHT_BORDER - middle_of_screen[0]


func _handle_switch_camera_view():
	# Get size of visible viewport:
	var visible_viewport_size = VIEWPORT.get_visible_rect().size
	var visible_y_axis_len = visible_viewport_size[1]
	
	# Get mouse pos
	var mouse_pos = VIEWPORT.get_mouse_position()
	var mouse_y_pos = mouse_pos[1]
	
	var border_thresh = visible_y_axis_len * (CAMERA_VIEW_THRESH / 100)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_handle_cam_pan()
	
	_handle_switch_camera_view()
