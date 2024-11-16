class_name Hallway
extends Room
var player_room: PlayerRoom = null

var player_inside = false


# Called when node gets loaded
func _ready() -> void:
	super()
	
	SignalBus.connect("player_entering", _on_player_entering)
	SignalBus.connect("player_leaving", _on_player_leaving)


# Handles player entering
func _on_player_entering(room_name: String):
	if room_name != self.name:
		return

	self.show_room()


# Handles door closing
func _on_player_leaving(room_name: String):
	if room_name != self.name:
		return

	self.hide_room()
