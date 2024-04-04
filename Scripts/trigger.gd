extends Node3D

signal trigger_activate()

@export var triggerName : String # Default is Default
@export_category("Paramiters")
@export var requiredTriggers : int #Can never be 0
@export var maxActivations : int #Set to -1 for infinite activations
var triggers : int
var activations : int
@onready var canTrigger : bool = true

func _ready() -> void:
	activations = 0
	if get_parent() is Area3D:
		get_parent().body_entered.connect(trigger_triggered)
		get_parent().body_exited.connect(trigger_disabled)
	if requiredTriggers <= 0:
		requiredTriggers = 1
	if maxActivations == 0 || maxActivations <= -2:
		push_error(triggerName + " maxActivations set to invalid value, value should be either -1 or a positive intiger. Setting to 1.")
		maxActivations = 1

func _process(delta: float) -> void:
	if triggers == requiredTriggers:
		activations += 1
		trigger_activate.emit()
		triggers = 0
		print(triggerName + " has activated successfully")
	
	if activations == maxActivations:
		canTrigger = false

func trigger_triggered(body : Node3D):
	if !canTrigger:
		return
	triggers += 1
	canTrigger = false

func trigger_disabled(body : Node3D):
	if !canTrigger && !activations == maxActivations:
		canTrigger = true
