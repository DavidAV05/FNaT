class_name Door
extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

# Hitbox
@onready var hitbox: CollisionShape2D = $Area2D.get_child(0)
@onready var original_hitbox_shape: Shape2D = hitbox.shape
@export_group("Camera / zoom")
@onready var camera: GameCamera = get_tree().get_current_scene().camera
@export var zoom_duration: float = 1
@export var zoom_strength: Vector2 = Vector2(3, 2)

@export_group("Door room")
@export var connected_room_name = ""

var inside_door = false
var entering = false

# Gets called every frame? I think?
func _process(_delta: float) -> void:
	if not Input.is_action_pressed("general_click") and inside_door and not entering:
		inside_door = false
		SignalBus.emit_signal("player_leaving", connected_room_name)
		
		camera.zoom_to_pos(zoom_strength, hitbox.position, 0)
		camera.zoom_to_pos(Vector2(1, 1), hitbox.position, zoom_duration)


# Detect door clicked and 'go' to room.
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	# On press of button/door
	if event and Input.is_action_just_pressed("general_click") and not inside_door:
		inside_door = true
		entering = true
		
		camera.zoom_to_pos(zoom_strength, hitbox.position, zoom_duration)
		await get_tree().create_timer(zoom_duration).timeout
		camera.zoom_to_pos(Vector2(1, 1), hitbox.position, 0)
		
		# Await entering the door
		await get_tree().create_timer(zoom_duration)

		entering = false
		# Trigger player entering event in connected room
		SignalBus.emit_signal("player_entering", connected_room_name)
