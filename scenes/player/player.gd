extends CharacterBody3D


const MAX_SPEED = 5.0
const ACCELERATION = 10.0
const DECELERATION = 10.0
const JUMP_VELOCITY = 4.5
const mouse_sensitivity = 0.3

@onready var pCam: PhantomCamera3D = $PhantomCamera3D

func _input(event) -> void:
	if event is InputEventMouseMotion:
		var yaw = -event.relative.x * mouse_sensitivity
		var pitch = -event.relative.y * mouse_sensitivity
		var current_rotation = pCam.get_third_person_rotation_degrees()
		var new_pitch = clamp(current_rotation.x + pitch, -60, -20)
		var new_yaw = current_rotation.y + yaw
		pCam.set_third_person_rotation_degrees(Vector3(new_pitch, new_yaw, 0))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward").rotated(-pCam.get_third_person_rotation().y)
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction != Vector3.ZERO:
		# Apply acceleration towards the maximum speed
		var target_speed = direction.length() * MAX_SPEED
		velocity.x = lerp(velocity.x, direction.x * target_speed, ACCELERATION * delta)
		velocity.z = lerp(velocity.z, direction.z * target_speed, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
		velocity.z = move_toward(velocity.z, 0, DECELERATION)

	move_and_slide()
