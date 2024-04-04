extends Node3D

enum CollectableTypes
{
	Item,
	Secret,
	Scene,
	Misc
}

@export var collectableType : CollectableTypes

func _ready() -> void:
	if get_parent().has_node("Interactable"):
		var interactableNode : Node3D = get_parent().get_node("Interactable")
		interactableNode.interaction_function.connect(incrument_collection)

func _process(delta: float) -> void:
	pass

func incrument_collection() -> void:
	match collectableType:
		CollectableTypes.Item:
			TrackedProgress.itemsCollected +=1
		CollectableTypes.Secret:
			TrackedProgress.secretsFound += 1
		CollectableTypes.Scene:
			TrackedProgress.bonusScenesFound += 1
		CollectableTypes.Misc:
			TrackedProgress.otherSecrets += 1