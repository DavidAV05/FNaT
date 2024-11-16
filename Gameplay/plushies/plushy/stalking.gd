extends State

@export var plushy: Plushy = null

@onready var attack_timer: Timer = $AttackTimer
@onready var cuddle_timer: Timer = $CuddleTimer

func enter():
	assert(plushy != null)
	print("I, %s am Stalking..." % plushy.name)

	var aggression = plushy.aggression
	if aggression <= 0:
			aggression = 1
	
	SignalBus.connect("player_entering", _start_cuddling)
	
	attack_timer.wait_time = plushy.base_attack_time / (aggression * 0.5)
	cuddle_timer.wait_time = attack_timer.wait_time / 2
	
	attack_timer.start()


func _start_cuddling(room_name: String):
	room_name = room_name.to_lower()
	var current_room_name = plushy.current_room.name.to_lower()

	if room_name == current_room_name:
		cuddle_timer.start()

# When attack timer runs out
func _on_attack_timer_timeout() -> void:
	print("You got jumpscared lol")
	SignalBus.emit_signal("game_over")


# When cuddle timer runs out
func _on_cuddle_timer_timeout() -> void:
	plushy._enter_new_room()
	Transition.emit(self, "Roaming")
