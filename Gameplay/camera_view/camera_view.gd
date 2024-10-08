class_name CameraView
extends Control

# Initial room showed upon switching to view
@export var starting_room_name: String = ""

# Uesd internally
var last_viewed_room_name: String = ""

# Used externally
var VIEW_OPENED := false
var JUST_OPENED := false

# Create signal for when cam button pressed
signal cam_button_pressed(button_name: String) 

# Create signals for hiding/showing
signal show_cams

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set initial room shown when flipping to view
	SignalBus.emit_signal("show_room", starting_room_name)
	last_viewed_room_name = starting_room_name
	
	# Connect the press of buttons to function
	cam_button_pressed.connect(_on_cam_button_pressed)
	
	# Hide / show cam view signals
	show_cams.connect(_show_view)
	SignalBus.connect("hide_cams", _hide_view)


# Show view of cams
func _show_view() -> void:
	self.show()
	SignalBus.emit_signal("show_room", last_viewed_room_name)

# Hide view of cams
func _hide_view() -> void:
	self.hide()

func _on_cam_button_pressed(room_name: String) -> void:
	print("I clicked %s hihi" % room_name)
	SignalBus.emit_signal("show_room", room_name)
	
	last_viewed_room_name = room_name
