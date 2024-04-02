extends Node3D

##Activates an event tied to the object
signal trigger_activate()

@export var triggerName : String
@export var requiredTriggers : int ##Can never be 0
@export var maxActivations : int ##Set to -1 for infinite activations
var triggers : int
var activations : int
var canTrigger : bool

func _ready() -> void:
	activations = 0
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
