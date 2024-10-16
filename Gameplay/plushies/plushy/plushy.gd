class_name Plushy
extends Node2D

# Determine appearance
@export_group("Appearance")
# For every room (key), different texture (value)
@export var textures_dict: Dictionary = {}
var all_sprites: Array[Sprite2D] = []

# Determine aggresiveness of plushy
@export_group("Aggresion")
@export_range(1, 20) var aggression_level: int = 1
@export_range(1, 5) var inherent_aggression: int = 1
var aggression: int = 0
var shortest_wait: int = 3
var longest_wait: int = 5

# Determine room status of plushy
@export_group("Room")
@export var starting_room: Room = null
var current_room: Room = null

@onready var TIMER = $ActionTimer
var rand = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_room = starting_room
	assert(starting_room != null)
	current_room.emit_signal("plushy_entered", self)

	aggression = aggression_level * inherent_aggression / 4
	if aggression <= 0:
		aggression = 1

	TIMER.wait_time = rand.randi_range(shortest_wait, longest_wait) / aggression
	TIMER.start()
	print("%s starting in room %s" % [self.name, current_room.name])
	
	# Append all child as order in node tree
	for child in get_children():
		if child is Sprite2D:
			# hide sprites at beginning
			child.hide()
			all_sprites.append(child)


# Handle entering a new room
func _enter_room(new_room: Room):
	assert(new_room != null)
	current_room.emit_signal("plushy_left", self)
	# Signal old current room plushy left
	current_room = new_room
	
	# Signal new room plushy entered
	new_room.emit_signal("plushy_entered", self)


# Hides all sprites
func hide_all_sprites() -> void:
	for sprite in all_sprites:
		sprite.hide()


# Hides all other sprites and shows current room's sprite
func update_sprite_on_room_id(room_id: int) -> void:
	for sprite in all_sprites:
		if sprite != all_sprites[room_id]:
			sprite.hide()
		elif sprite == all_sprites[room_id]:
			sprite.show()


# Handle moving into new room when timer done
func _on_action_timer_timeout() -> void:
	# Pick a new room to move to
	var new_room = current_room.accesible_rooms.pick_random()
	print("I, %s moved to %s" % [self.name, new_room.name])

	# Enter the new room
	_enter_room(new_room)
	TIMER.wait_time = rand.randi_range(shortest_wait, longest_wait) / aggression
	TIMER.start()
