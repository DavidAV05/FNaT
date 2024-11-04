class_name PlayerRoom
extends Room


func _ready() -> void:
	# Calls ready function of base class (room)
	super()


func _plushy_entered(new_plushy: Plushy):
	print("Dood lol door %s\n\n" % new_plushy)
	SignalBus.emit_signal("game_over")
