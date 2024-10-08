class_name Room
extends Node2D

@export_group("Bookkeeping")
@export var room_id: int = -1
@export var accesible_rooms: Array[Room] = []
var pluhsies_inside: Array[Plushy] = []

# Sprite
@onready var sprite: Sprite2D = $Sprite2D

signal plushy_entered
signal plushy_left

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(sprite != null)
	
	plushy_entered.connect(_plushy_entered)
	plushy_left.connect(_plushy_left)

func _plushy_entered(new_plushy: Plushy):
	pluhsies_inside.append(new_plushy)
	print("%s has %s in it now" % [self.name, new_plushy.name])

func _plushy_left(leaving_plushy: Plushy):
	pluhsies_inside.erase(leaving_plushy)
	print("%s has lost %s" % [self.name, leaving_plushy.name])


# Handle room appereance when camera of room is selected
func show_room():
	for plushy in pluhsies_inside:
		plushy.show()

	self.show()

# Handle room disappereance when camera of room is deselected
func hide_room():
	for plushy in pluhsies_inside:
		plushy.hide()

	self.hide()
