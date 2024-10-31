extends Control

@export_range(1, 1.5, 0.05) var tween_intensity: float = 1.3
@export_range(0, 0.3) var tween_duration: float = 0.1
var buttons: Array[Button] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Button:
			buttons.append(child)
			child.mouse_entered.connect(_button_hovered.bind(child))
			child.mouse_exited.connect(_button_unhovered.bind(child))


# Starts tweening
func _start_tween(object: Object, poperty: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, poperty, final_val, duration)


# Changes appearance button on hover
func _button_hovered(button: Button):
	button.pivot_offset = button.size / 2
	_start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)


# Changes appearance button on unhover
func _button_unhovered(button: Button):
	_start_tween(button, "scale", Vector2.ONE, tween_duration)
