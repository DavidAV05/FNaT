extends Node2D

@export var inside_door_scene: Node2D = null

@onready var hitbox: CollisionShape2D = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if inside_door_scene == null:
		print("Forgot to assign scene door '%s'" % self.name)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		inside_door_scene.show()
		print("Clicked")
	elif event is InputEventMouseButton and event.is_released():
		print("Let go")
		inside_door_scene.hide()
	
