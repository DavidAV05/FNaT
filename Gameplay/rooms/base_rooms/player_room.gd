class_name PlayerRoom
extends Room

func _plushy_entered(new_plushy: Plushy):
	print("Dood lol\n\n")
	SignalBus.emit_signal("game_over")
