extends NavigationAgent3D
class_name MovementComponent

@export var unit: Unit
@export_category("Component Parameters")
@export var speed: float = 5.0
@export var acceleration: float = 2.0


func _physics_process(delta: float) -> void:
	unit.velocity = calculate_velocity(unit.global_position)
	unit.move_and_slide()


func calculate_velocity(position: Vector3) -> Vector3:
	if self.is_navigation_finished():
		return Vector3.ZERO
	var direction = position.direction_to(self.get_next_path_position())
	var motion = direction * speed
	return motion
