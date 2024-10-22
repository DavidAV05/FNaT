extends Node2D

var rooms: Array[Room] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Room:
			rooms.append(child)
			child.hide()


	# Connect show room to function from signalbus
	SignalBus.connect("show_room", _show_room_on_name)

	# Connect hide room to function from signalbus
	SignalBus.connect("hide_cams", _hide_all_rooms)


# Show room based on what name has been given
func _show_room_on_name(room_name: String) -> void:
	for room in rooms:
		if room.name == room_name:
			room.show_room()
		else:
			room.hide_room()


# Hide all rooms
func _hide_all_rooms() -> void:
	for room in rooms:
		room.hide_room()
