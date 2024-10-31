extends Node

signal hide_cams

signal show_room(room_name: String)
signal hide_room(room_name: String)

signal player_entering(room_name: String)
signal player_leaving(room_name: String)

signal game_over
