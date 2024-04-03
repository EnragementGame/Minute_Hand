extends Area3D
#Trigger nodes are placed on Nodes that have some sort of functonality, such as
#A door that needs a button to open, or an area that will activate a cutscene
#or dialogue. While they are Area3D nodes, they don't have to be used as such.

#Activates an event tied to the object
signal trigger_activate()

@export var triggerName : String
@export_category("Paramiters")
@export var requiredTriggers : int #Can never be 0
@export var maxActivations : int #Set to -1 for infinite activations
@export_category("Area Trigger")
@export var isAreaTrigger : bool
@export var areaSize : Vector3
@onready var areaTrigger : BoxShape3D = %AreaTrigger.shape
var triggers : int
var activations : int
@onready var canTrigger : bool = true

func _ready() -> void:
	activations = 0
	if requiredTriggers <= 0:
		requiredTriggers = 1
	if maxActivations == 0 || maxActivations <= -2:
		push_error(triggerName + " maxActivations set to invalid value, value should be either -1 or a positive intiger. Setting to 1.")
		maxActivations = 1
	areaTrigger.size = areaSize

func _process(delta: float) -> void:
	if triggers == requiredTriggers:
		activations += 1
		trigger_activate.emit()
		triggers = 0
	
	if activations == maxActivations:
		canTrigger = false

func _on_body_entered(body:Node3D) -> void:
	if !canTrigger:
		return
	if isAreaTrigger:
		triggers += 1
		canTrigger = false

func _on_body_exited(body:Node3D) -> void:
	if !canTrigger && !activations == maxActivations:
		canTrigger = true