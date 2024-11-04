class_name StateMachine
extends Node

var states: Dictionary = {}

# Keep track of state
@export var initial_state: State = null
var current_state: State = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transition.connect(_change_state)
	
	print("Initial state: %s" % initial_state.name)
	if initial_state:
		current_state = initial_state
		initial_state.enter()


# Set new current value
func _change_state(old_state: State, new_state_name: String) -> void:
	print("Chaning state in state macine")
	new_state_name = new_state_name.to_lower()
	if old_state != current_state:
		return

	if new_state_name not in states.keys():
		print("%s not in " % new_state_name, states.keys())
		return

	if current_state:
		current_state.exit()

	var new_state = states[new_state_name]
	new_state.enter()

	current_state = new_state
	print("Finished changing state")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_state.update(delta)


# Called every fixed interval, 'delta' is constant.
func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)
