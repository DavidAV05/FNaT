extends State

@export var plushy: Plushy = null
@onready var timer = $ActionTimer

var rand = RandomNumberGenerator.new()
 
# Called whenever state gets entered
func enter() -> void:
	assert(plushy != null)
	print("%s is now roaming" % plushy.name)
	timer.wait_time = plushy.wander_time
	timer.start()


# Handle moving into new room when timer done
func _on_action_timer_timeout() -> void:
	# Enter the new room
	var new_room = plushy._enter_new_room()

	# If plushy enters hallway, switch states
	if new_room is Hallway:
		print("Transitioning to stalking")
		Transition.emit(self, "Stalking")
		return

	timer.wait_time = plushy.wander_time
	timer.start()
