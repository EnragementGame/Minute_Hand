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
@export_category("Size")
@export var switchSize : Vector3
@onready var switchArea : BoxShape3D = %SwitchInteraction.shape
var active : bool
@onready var canUse : bool = true

func _ready():
	for i in linkedTriggers:
		if !i.has_node("res://Scenes/Components/trigger.tscn"):
			push_error(switchName + " switch linked to object without trigger")
	
	switchArea.size = switchSize

	if activeTimer < 0.2:
		activeTimer = 0.2

	if onToStart:
		active = true
		
		activeLenght.start(activeTimer)
		switch_active.emit()

func _on_interactable_interaction_function() -> void:
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
