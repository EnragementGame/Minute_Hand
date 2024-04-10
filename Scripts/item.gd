extends Node3D

signal item_pickup()
signal item_putdown()

@export var itemName : String
@export_category("Triggers")
@export var linkedTriggers : Array[Node3D]
@export_category("Conditions")
@export var destroyAfterPickup : bool
@onready var pickedUp : bool = false
var storedLocation : Vector3
var interactableNode : Node3D
@onready var isPickedUp : bool = false

func _ready() -> void:
	if get_parent().has_node("Interactable"):
		interactableNode = get_parent().get_node("Interactable")
		interactableNode.interaction_function.connect(pickup)
	else:
		push_error(itemName + " is on an object without and Interactable component.")

func _process(delta: float) -> void:
	pass

#Brings the item close and causes the player to enter a sort of "inspection" state
func pickup() -> void:
	storedLocation = position
	interactableNode.playerInteracting.inspectionState = true
	position = interactableNode.playerInteracted.get_parent().position + (interactableNode.playerInteracting.get_parent().FORWARD * 3)
