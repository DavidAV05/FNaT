extends Control

func _ready() -> void:
	self.hide()
	SignalBus.connect("game_over", _game_over)

func _game_over() -> void:
	self.show()
	Engine.time_scale = 0

func _on_button_pressed() -> void:
	print("Klik haha")
	Engine.time_scale = 1
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
