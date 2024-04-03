extends CharacterBody3D

@export_category("Speed")
@export var walkSpeed : float
@export var sprintSpeed : float
var speed : float
var direction : Vector3
@export var gravity : float
@export_category("Stamina")
@export var maxStamina : float
@onready var stamina : float = maxStamina
var regenStamina : bool
var canLoseStamina : bool
@onready var staminaBuffer : Timer = %StaminaBuffer
@onready var recoveryTimer : Timer = %RecoveryTimer
@export_category("Camera")
@export var sensitivity : float
@onready var cam : Camera3D = %Cam
var camLimit : float = 89

func _ready() -> void:
	lock_mouse()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	move()

	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-deg_to_rad(event.relative.x * sensitivity))
		cam.rotate_x(-deg_to_rad(event.relative.y * sensitivity))
		cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-camLimit), deg_to_rad(camLimit))

func move():
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if running():
		speed = sprintSpeed
	else:
		speed = walkSpeed

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)


func running() -> bool:
	if Input.is_action_pressed("Run") && stamina > 0:
		return true
	else:
		return false

func lock_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func unlock_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_recovery_timer_timeout() -> void:
	regenStamina = true

func _on_stamina_buffer_timeout() -> void:
	canLoseStamina = true
