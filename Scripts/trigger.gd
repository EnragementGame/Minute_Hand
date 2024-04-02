extends Area3D
#Trigger nodes are placed on Nodes that have some sort of functonality, such as
#A door that needs a button to open, or an area that will activate a cutscene
#or dialogue. While they are Area3D nodes, they don't have to be used as such.

#Activates an event tied to the object
signal trigger_activate()

@export var triggerName : String
@export_category("Paramiters")
@export var areaTrigger : bool
@export var interactableTriger : bool
@export var requiredTriggers : int #Can never be 0
@export var maxActivations : int #Set to -1 for infinite activations
var triggers : int
var activations : int
var canTrigger : bool

func _ready() -> void:
	activations = 0
	if requiredTriggers <= 0:
		requiredTriggers = 1
	if maxActivations == 0:
		push_error(triggerName + " maxActivations set to 0, value should be either -1 or a positive intiger. Setting to 1.")
		maxActivations = 1

func _process(delta: float) -> void:
	if triggers == requiredTriggers:
		activations += 1
		trigger_activate.emit()
		triggers = 0
	
	if activations == maxActivations:
		canTrigger = false

func _on_area_entered(area:Area3D) -> void:
	if area != self || !canTrigger:
		return
	if areaTrigger:
		triggers += 1

func _on_interactable_interaction_function() -> void:
	if !canTrigger:
		return
	if interactableTriger:
		triggers += 1
