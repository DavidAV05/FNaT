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
var aggression = aggression_level * inherent_aggression / 4
var base_attack_time: int = 5
var base_cuddle_time: int = 2
var shortest_wait: int = 3
var longest_wait: int = 5

var rand = RandomNumberGenerator.new()
@onready var wander_time: float = 0:
	set(new_value):
		wander_time = new_value
	get:
		if aggression <= 0:
			aggression = 1

		return rand.randi_range(shortest_wait, longest_wait) / aggression 

# Determine room status of plushy
@export_group("Room")
@export var starting_room: Room = null
var current_room: Room = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_room = starting_room
	assert(starting_room != null)
	current_room.emit_signal("plushy_entered", self)

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
	# Signal old current room plushy left
	current_room.emit_signal("plushy_left", self)
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
