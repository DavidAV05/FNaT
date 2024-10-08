extends Button

@export var connected_room_name: String = ""

@onready var parent: Node = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()

# When button is pressed
func _on_pressed() -> void:
	parent.emit_signal("cam_button_pressed", self.connected_room_name)
