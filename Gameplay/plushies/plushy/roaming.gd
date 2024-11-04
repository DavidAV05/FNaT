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
	# Pick a new room to move to
	var new_room = plushy.current_room.accesible_rooms.pick_random()
	print("I, %s moved to %s" % [self.name, new_room.name])

	# Enter the new room
	plushy._enter_room(new_room)

	# If plushy enters hallway, switch states
	if new_room is Hallway:
		print("Transitioning to stalking")
		Transition.emit(self, "Stalking")
		return

	timer.wait_time = plushy.wander_time
	timer.start()
