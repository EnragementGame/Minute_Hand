extends Node3D

@export var itemName : String
@export_category("Triggers")
@export var linkedTriggers : Array[Node3D]
@export_category("Conditions")
@export var destroyAfterPickup : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_parent().has_node("Interactable"):
		var interactableNode : Node3D = get_parent().get_node("Interactable")
		interactableNode.interaction_function.connect(pickup)
	else:
		push_error(itemName + " is on an object without and Interactable component.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func pickup() -> void:
	pass