extends Node2D

@export_range(0, 50) var MOTION_SCALE := 5.0

var backdrops: Array[Sprite2D] = []
var initial_positions: Array[Vector2] = []
var middle_of_screen: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get the center of the viewport
	middle_of_screen = Vector2(get_viewport().size) / 2
	
	# Get all children who are Sprite2D
	for child in self.get_children():
		if child is Sprite2D:
			backdrops.append(child)
			# Store their initial positions
			initial_positions.append(child.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var total_backdrops = backdrops.size()

	# Calculate the offset based on the current mouse position relative to the viewport center
	var mouse_offset = get_global_mouse_position() - middle_of_screen

	for i in range(total_backdrops):
		var current_scale: float = (MOTION_SCALE * (i + 1)**2) / total_backdrops
		if backdrops[i]:
			# Calculate the new position for each backdrop based on the mouse offset and scale
			backdrops[i].position = initial_positions[i] + (mouse_offset * current_scale * delta)
