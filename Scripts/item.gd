extends Node3D

@export var itemName : String
@export_category("Triggers")
@export var linkedTriggers : Array[Node3D]
@export_category("Conditions")
@export var destroyAfterPickup : bool
@onready var pickedUp : bool = false

func _ready() -> void:
	if get_parent().has_node("Interactable"):
		var interactableNode : Node3D = get_parent().get_node("Interactable")
		interactableNode.interaction_function.connect(pickup)
	else:
		push_error(itemName + " is on an object without and Interactable component.")

func _process(delta: float) -> void:
	pass

func pickup() -> void:
	pass