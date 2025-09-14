extends RigidBody3D

var strength = 10

func _init() -> void:
	linear_damp = .5
	angular_damp = .5

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE: 
			hit(Vector3(0, 5, 0))
		if event.keycode == KEY_LEFT:
			hit(Vector3(5, 0, 0))
		if event.keycode == KEY_RIGHT:
			hit(Vector3(-5, 0, 0))
		if event.keycode == KEY_UP:
			hit(Vector3(0, 0, 5))
		if event.keycode == KEY_DOWN:
			hit(Vector3(0, 0, -5))

func move(direction: Vector3) -> void:
	apply_central_force(direction)

func hit(direction: Vector3) -> void:
	apply_central_impulse(direction)
