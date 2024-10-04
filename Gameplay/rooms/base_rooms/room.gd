class_name Room
extends Node2D

@export_group("Bookkeeping")
@export var ROOM_ID: int = -1
@export var accesible_rooms: Array[Room] = []
var pluhsies_inside: Array[Plushy] = []

@export_group("Appearance")
@export var ROOM_TEXTURE: Texture = null
var SPRITE: Sprite2D = null

signal plushy_entered
signal plushy_left

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.show_room.connect(show_room)
	SignalBus.hide_room.connect(hide_room)
	
	SPRITE = $Sprite
	assert(ROOM_TEXTURE != null)
	assert(SPRITE != null)
	SPRITE.texture = ROOM_TEXTURE
	
	plushy_entered.connect(_plushy_entered)
	plushy_left.connect(_plushy_left)

func _plushy_entered(new_plushy: Plushy):
	pluhsies_inside.append(new_plushy)
	print("%s has %s in it now" % [self.name, new_plushy.name])

func _plushy_left(leaving_plushy: Plushy):
	pluhsies_inside.erase(leaving_plushy)
	print("%s has lost %s" % [self.name, leaving_plushy.name])


# Handle room appereance when camera of room is selected
func show_room(called_room: Room):
	if called_room != self:
		return
	
	for plushy in pluhsies_inside:
		plushy.show()
	
	self.show()

# Handle room disappereance when camera of room is deselected
func hide_room(called_room: Room):
	if called_room != self:
		return
	
	for plushy in pluhsies_inside:
		plushy.hide()

	self.hide()
