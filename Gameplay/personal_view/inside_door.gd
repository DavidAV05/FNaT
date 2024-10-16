extends Node2D

@export var SPRITE_TEXTURE: Texture2D = null

@onready var SPRITE: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SPRITE.texture = SPRITE_TEXTURE
	self.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
