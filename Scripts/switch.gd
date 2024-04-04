extends Node3D

signal switch_active()
signal switch_deactivate()


@export var switchName : String
@export_category("Triggers")
@export var linkedTriggers : Array[Node3D]
@export_category("Conditions")
@export var isToggle : bool
@export var singleUse : bool
@export var onToStart : bool
@export_category("Timers")
@export_range(0.2, 30) var activeTimer : float
@export var delay : float #Leave zero for no delay
@onready var activeLenght : Timer = %ActiveLength
@onready var delayTimer : Timer = %ActivationDelay
var active : bool
@onready var canUse : bool = true

func _ready():
	for i in linkedTriggers:
		if i != get_node("res://Scenes/Components/trigger.tscn"):
			push_error(switchName + " switch linked to object without trigger")
	
	if get_parent().has_node("Interactable"):
		var interactableNode : Node3D = get_parent().get_node("Interactable")
		interactableNode.interaction_function.connect(interactable_link)
	else:
		push_error(switchName + " is on an object without and Interactable component.")

	if activeTimer < 0.2:
		activeTimer = 0.2

	if onToStart:
		active = true
		
		activeLenght.start(activeTimer)
		switch_active.emit()

func interactable_link() -> void:
	if canUse:
		delayTimer.start(delay)
		canUse = false

func _on_activation_delay_timeout() -> void:
	if isToggle && active:
		active = false
		canUse = true
		switch_deactivate.emit()
		return

	active = true
	switch_active.emit()
	for i in linkedTriggers:
		i.triggers += 1
	if !isToggle:
		activeLenght.start(activeTimer)
	else:
		canUse = true

func _on_active_length_timeout() -> void:
	active = false
	switch_deactivate.emit()
	delayTimer.stop()
	if singleUse:
		canUse = false
	else:
		canUse = true
