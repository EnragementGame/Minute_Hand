extends Node3D

##highlights object when hovered over
##registers when is interacted with
signal interaction_function()

func highlight():
	pass

func interacted():
	interaction_function.emit()