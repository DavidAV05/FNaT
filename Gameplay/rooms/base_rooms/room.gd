class_name Room
extends Node2D

@export_group("Bookkeeping")
@export var room_id: int = -1
@export var accesible_rooms: Array[Room] = []
var plushies_inside: Array[Plushy] = []
var being_shown = false

# Sprite
@onready var sprite: Sprite2D = $Sprite2D

signal plushy_entered
signal plushy_left

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(sprite != null)
	
	plushy_entered.connect(_plushy_entered)
	plushy_left.connect(_plushy_left)
	
	# When cams get hidden, hide room
	SignalBus.connect("hide_cams", hide_room)

func _plushy_entered(new_plushy: Plushy):
	# Add to bookkeeping
	plushies_inside.append(new_plushy)
	
	# Shows the plushy when entering if room is being shown
	if being_shown:
		new_plushy.update_sprite_on_room_id(room_id)
	print("%s has %s in it now" % [self.name, new_plushy.name])


# Handles plushy leaving the room
func _plushy_left(leaving_plushy: Plushy):
	# Erase from bookkeeping
	plushies_inside.erase(leaving_plushy)
	
	# Hides the plushy when leaving
	leaving_plushy.hide_all_sprites()
	print("%s has lost %s" % [self.name, leaving_plushy.name])


# Handle room appereance when camera of room is selected
func show_room():
	for plushy in plushies_inside:
		plushy.update_sprite_on_room_id(room_id)

	being_shown = true
	self.show()

# Handle room disappereance when camera of room is deselected
func hide_room():
	for plushy in plushies_inside:
		plushy.hide_all_sprites()

	being_shown = false
	self.hide()
