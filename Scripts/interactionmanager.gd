extends Node3D

var selectedInteractable : Node3D
@onready var interactionRay : RayCast3D = %InteractionCheck

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if interactionRay.is_colliding():
		if interactionRay.get_collider().has_node("Interactable"):
			selectedInteractable = interactionRay.get_collider()
			print(selectedInteractable.name)
		else:
			selectedInteractable = null
	else:
		selectedInteractable = null
	if Input.is_action_just_pressed("Interact") && selectedInteractable != null:
		selectedInteractable.get_node("Interactable").interacted()
		print("worked")
