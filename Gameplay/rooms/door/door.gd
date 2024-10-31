class_name Door
extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

# Hitbox
@onready var hitbox: CollisionShape2D = $Area2D.get_child(0)
@onready var original_hitbox_shape: Shape2D = hitbox.shape

@export var connected_room_name = ""

var inside_door = false


# Gets called every frame? I think?
func _process(delta: float) -> void:
	if Input.is_action_just_released("general_click") and inside_door:
		inside_door = false
		SignalBus.emit_signal("player_leaving", connected_room_name)


# Detect door clicked and 'go' to room.
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	# On press of button/door
	if event and Input.is_action_just_pressed("general_click") and not inside_door:
		inside_door = true
		# Trigger player entering event in connected room
		SignalBus.emit_signal("player_entering", connected_room_name)
	
	# Letting go of button is handled in _process
