extends NavigationAgent3D
class_name MovementComponent

@export var unit: Unit
@export_category("Component Parameters")
@export var speed: float = 10.0
@export var acceleration: float = 5.0


func _physics_process(delta: float) -> void:
	# TODO i'm not sure if normalizing here is a good idea, feels like I'm throwing
	# away possible useful engine C++ code only to roll my own, please investigate further
	var direction := calculate_direction(unit.global_position).normalized()
	unit.velocity = unit.velocity.lerp(direction * speed, acceleration * delta)
	unit.move_and_slide()


func calculate_direction(position: Vector3) -> Vector3:
	if self.is_navigation_finished():
		return Vector3.ZERO
	var direction = position.direction_to(self.get_next_path_position())
	var motion = direction * speed
	return motion
