extends Node3D

signal switch_active()

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
		if !i.has_node("res://Scripts/trigger.gd"):
			push_error(name + " switch linked to object without trigger")
	
	if activeTimer < 0.2:
		activeTimer = 0.2

	if onToStart:
		active = true
		
		activeLenght.start(activeTimer)

func _on_interactable_interaction_function() -> void:
	if !isToggle && active:
		return
	
	if canUse:
		delayTimer.start(delay)

func _on_activation_delay_timeout() -> void:
	if isToggle && active:
		active = false
		return

	active = true
	for i in linkedTriggers:
		i.triggers += 1
	if !isToggle:
		activeLenght.start(activeTimer)

func _on_active_length_timeout() -> void:
	active = false
	if singleUse:
		canUse = false
