extends Control
class_name CameraView

@export_range(0, 20, 0.5) var FLIP_TRESH := 10.0

var FLIP_BORDER := 0.0
var CAM_BUTTONS: Array[Button] = [] 
var ROOMS: Array[Room] = []

var VIEWPORT_SIZE: Vector2 = Vector2(0, 0)

var VIEW_OPENED := false
var JUST_OPENED := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	VIEWPORT_SIZE = get_viewport().get_visible_rect().size
	FLIP_BORDER = VIEWPORT_SIZE[1] * (FLIP_TRESH / 100) 
	for child in self.get_children():
		if child is Button:
			CAM_BUTTONS.append(child)
		if child is Room:
			ROOMS.append(child)


func _on_cam_butten_press(button_name: String) -> void:
	pass
