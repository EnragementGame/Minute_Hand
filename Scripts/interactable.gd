extends Node3D

signal interaction_function()

#highlights object when hovered over
func highlight():
	pass

#registers when is interacted with
func interacted():
	interaction_function.emit()