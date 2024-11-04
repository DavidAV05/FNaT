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
	
	attack_timer.wait_time = plushy.base_attack_time / (aggression * 0.5)
	cuddle_timer.wait_time = plushy.base_cuddle_time / (aggression * 0.5)
	
	attack_timer.start()


# When attack timer runs out
func _on_attack_timer_timeout() -> void:
	print("You got jumpscared lol")
	SignalBus.emit_signal("game_over")


# When cuddle timer runs out
func _on_cuddle_timer_timeout() -> void:
	Transition.emit(self, "Roaming")
