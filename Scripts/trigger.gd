extends Node3D

##Activates an event tied to the object
signal trigger_activate()

@export var requiredTriggers : int ##Can never be 0
@export var maxActivations : int ##Can never be 0
var triggers : int
var activations : int
var canTrigger : bool

func _ready() -> void:
	if requiredTriggers <= 0:
		requiredTriggers = 1
	if maxActivations <= 0:
		maxActivations = 1

func _process(delta: float) -> void:
	if triggers == requiredTriggers:
		activations += 1
		trigger_activate.emit()
		triggers = 0
	
	if activations == maxActivations:
		canTrigger = false
