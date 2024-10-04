class_name Hallway
extends Room

@export var DOOR: Node = null

var PLAYER_ROOM: PlayerRoom = null

signal player_entered
signal player_left

# Initialises the PLAYER_ROOM, which is the room with the player
func _ready() -> void:
	for room in ACCESIBLE_ROOMS:
		if room is PlayerRoom:
			assert(PLAYER_ROOM == null)
			PLAYER_ROOM = room
	
	player_entered.connect(_on_player_entering)
	player_left.connect(_on_player_leaving)


# Handles player entering
func _on_player_entering():
	pass


# Handles door closing
func _on_player_leaving():
	pass
