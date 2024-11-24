extends Control

@export var main_menu: PackedScene = null
@onready var audio: AudioStreamPlayer2D = $Audio

func _ready() -> void:
	assert(main_menu != null)
	self.hide()
	SignalBus.connect("game_over", _game_over)

func _game_over() -> void:
	print_debug("Dood lol")
	self.show()
	audio.play()
	Engine.time_scale = 0

func _on_button_pressed() -> void:
	Engine.time_scale = 1
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu)
