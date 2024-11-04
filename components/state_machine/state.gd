class_name State
extends Node

signal Transition(old_state, new_state)

# Called whenever state is entered
func enter():
	pass


# Called whenever state is exited
func exit():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	pass
