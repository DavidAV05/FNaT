extends Sprite2D

@onready var shader_material: ShaderMaterial = self.material
var timer: Timer = null

var timeout_time: float = 0.1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shader_material.set_shader_parameter("fade", 4)
	
	var timer = get_tree().create_timer(timeout_time)
	timer.timeout.connect(_on_timer_timeout)


# On timer time_out
func _on_timer_timeout():
	var fade = shader_material.get_shader_parameter("fade")
	shader_material.set_shader_parameter("fade", fade - 1)
	
	if fade > 0:
		var timer = get_tree().create_timer(timeout_time)
		timer.timeout.connect(_on_timer_timeout)
