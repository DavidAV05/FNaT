extends Node2D
class_name Plushy

# Determine aggresiveness of plushy
@export_category("Aggresion")
@export_range(1, 20) var AGGRESION_LEVEL: int = 1
@export_range(1, 5) var INHERENT_AGGRESION: int = 1
var AGGRESION: int = 0
var SHORTEST_TIME: int = 3
var LONGEST_TIME: int = 5

# Determine room status of plushy
@export_category("Room")
@export var _STARTING_ROOM: Room = null
var CURRENT_ROOM: Room = null

@onready var TIMER = $ActionTimer
var RAND = RandomNumberGenerator.new()

@onready var Sprites: AnimatedSprite2D = $Sprites

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CURRENT_ROOM = _STARTING_ROOM
	assert(_STARTING_ROOM != null)

	AGGRESION = AGGRESION_LEVEL * INHERENT_AGGRESION / 4
	if AGGRESION <= 0:
		AGGRESION = 1

	TIMER.wait_time = RAND.randi_range(SHORTEST_TIME, LONGEST_TIME) / AGGRESION
	TIMER.start()
	print("%s starting in room %s" % [self.name, CURRENT_ROOM.name])


# Handle entering a new room
func _enter_room(new_room: Room):
	# Check if new room
	assert(new_room != null)

	# Get old room and new roow
	var old_room = CURRENT_ROOM
	CURRENT_ROOM = new_room

	# Make plushy change sprite according to room
	_room_sprite_change(new_room.ROOM_ID)

	# Emit signal to rooms after updating CURRENT_ROOM
	old_room.emit_signal("plushy_left", self)
	new_room.emit_signal("plushy_entered", self)

func _room_sprite_change(room_id: int):
	assert(room_id >= 0)
	pass

# Handle moving into new room when timer done
func _on_action_timer_timeout() -> void:
	# Pick a new room to move to
	var new_room = CURRENT_ROOM.ACCESIBLE_ROOMS.pick_random()
	assert(new_room != null)
	print("%s moved to %s" % [self.name, new_room.name])

	# Enter the new room
	_enter_room(new_room)
	TIMER.wait_time = RAND.randi_range(SHORTEST_TIME, LONGEST_TIME) / AGGRESION
	TIMER.start()
