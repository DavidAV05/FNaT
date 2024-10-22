extends Button

@export var connected_room_name: String = ""

@export var camera_view: Node = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera_view = get_parent().get_parent()

# When button is pressed
func _on_pressed() -> void:
	camera_view.emit_signal("cam_button_pressed", self.connected_room_name)
