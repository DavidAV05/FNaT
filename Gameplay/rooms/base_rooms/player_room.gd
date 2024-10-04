extends Room
class_name PlayerRoom

@export var CURRENT_LEVEL: Node2D = null

func _plushy_entered(new_plushy: Plushy):
	for child in CURRENT_LEVEL.get_children():
		if child is Level:

			CURRENT_LEVEL.game_over()
