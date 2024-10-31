extends Node2D


# Start game button
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Gameplay/level/levels/level1.tscn")
	print("Starting game")


# Quit game button
func _on_quit_pressed() -> void:
	get_tree().quit()
