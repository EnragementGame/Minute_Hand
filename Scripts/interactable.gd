extends Node3D

signal interaction_function()

@export var canHighlight : bool #Determins if the object will be highlighted when hovered over
@onready var selected : bool = false

func _process(delta):
	if selected:
		highlight()

#highlights object when hovered over
func highlight():
	if !canHighlight:
		return
	pass

#registers when is interacted with
func interacted():
	interaction_function.emit()