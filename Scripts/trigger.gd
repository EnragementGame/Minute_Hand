extends Node3D
#Trigger nodes are placed on Nodes that have some sort of functonality, such as
#A door that needs a button to open, or an area that will activate a cutscene
#or dialogue. While they are Area3D nodes, they don't have to be used as such.

signal trigger_activate()

@export var triggerName : String
@export_category("Paramiters")
@export var requiredTriggers : int #Can never be 0
@export var maxActivations : int #Set to -1 for infinite activations
var triggers : int
var activations : int
@onready var canTrigger : bool = true

func _ready() -> void:
	activations = 0
	if get_parent() == Area3D:
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

func trigger_triggered() -> void:
	if !canTrigger:
		return
	triggers += 1
	canTrigger = false

func trigger_disabled() -> void:
	if !canTrigger && !activations == maxActivations:
		canTrigger = true
