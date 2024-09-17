extends Node2D

@export_range(0, 50) var motion_scale: float = 5

var backdrops: Array[Sprite2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get all children who are Sprite2D
	for child in self.get_children():
		if child is Sprite2D:
			backdrops.append(child)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var total_backdrops = backdrops.size()
	
	# Get the center of the viewport
	var middle_of_screen = Vector2(get_viewport().size) / 2	

	# Calculate the offset based on the current mouse position relative to the viewport center
	var mouse_offset = get_global_mouse_position() - middle_of_screen

	for i in range(total_backdrops):
		var current_scale: float = (motion_scale * (i + 1)) / total_backdrops
		
		# Calculate the new position for each backdrop based on the mouse offset and scale
		backdrops[i].position = (mouse_offset * current_scale * delta * current_scale) - backdrops[i].position
