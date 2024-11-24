class_name GameCamera
extends Camera2D


@export_group("GameCamera")
@export var left_border := 0 
@export var right_border := 1792
@export_range(0, 20) var pan_speed := 5.0
@export_range(0, 50) var pan_thresh := 10.0

var viewport: Viewport = null

@onready var tween: Tween = null
var tweening = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set limits
	self.limit_left = left_border
	self.limit_right = right_border

	pan_speed = (right_border / 1000) * pan_speed
	
	viewport = get_viewport()


# Zooms to given position with given duration
func zoom_to_pos(pos: Vector2i, duration: float) -> void:
	# Avoid tween interference
	if tweening:
		return

	print("Zooming in to:", pos)
	set_process(false)
	tweening = true
	tween = create_tween() 
	tween.set_parallel(true)
	tween.tween_property(self, "position", Vector2(1152, 258), duration)
	tween.tween_property(self, "zoom", Vector2(4, 6), duration)
	tweening = false
	set_process(true)


# Resets zoom
func reset_zoom(pos: Vector2, duration: float) -> void:
	# Avoid tween interference
	if tweening:
		return

	set_process(false)
	tweening = true
	tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", Vector2(self.position[0], 324), duration)
	tween.tween_property(self, "zoom", Vector2(1, 1), duration)
	tweening = false
	set_process(true)


# Handles the panning of the camera
func _handle_pan() -> void:
	# Get size of visible viewport:
	var visible_viewport_size = viewport.get_visible_rect().size
	var visible_x_axis_len = visible_viewport_size[0]

	# Define when camera pans
	var border_thresh = visible_x_axis_len * (pan_thresh / 100)

	var middle_of_screen = (viewport.get_visible_rect().size / 2)
	var top_left_pos = self.position - middle_of_screen

	var mouse_pos = viewport.get_mouse_position()
	if mouse_pos[0] < border_thresh:
		# Check if after moving camera still right of self.limit_left
		if top_left_pos[0] - pan_speed > left_border:
			self.position[0] -= pan_speed
		# If after moving left of border, set camera at border
		elif top_left_pos[0] > left_border:
			self.position[0] = left_border + middle_of_screen[0]
	
	if mouse_pos[0] > visible_x_axis_len - border_thresh:
		# Check if after moving camera still left of self.limit_right
		if top_left_pos[0] + visible_x_axis_len + pan_speed < right_border:
			self.position[0] += pan_speed
		# If after moving right of border, set camera at border
		elif top_left_pos[0] + visible_x_axis_len < right_border:
			self.position[0] = right_border - middle_of_screen[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_handle_pan()
