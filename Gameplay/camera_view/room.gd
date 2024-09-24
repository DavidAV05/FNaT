extends Node2D
class_name Room

@export var ROOM_NAME: String = ""
@export var ACCESIBLE_ROOMS: Array[Room] = []
var PLUSHIES_INSIDE: Array[Plushy] = []

signal plushy_enetered
signal plushy_left

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	plushy_enetered.connect(_plushy_entered)

func _plushy_entered(new_plushy: Plushy):
	PLUSHIES_INSIDE.append(new_plushy)

func _plushy_left(leaving_plushy: Plushy):
	PLUSHIES_INSIDE.erase(leaving_plushy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
