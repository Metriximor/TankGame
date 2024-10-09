extends NavigationAgent3D
class_name MovementComponent

@export var unit: Unit
@export_category("Component Parameters")
@export var speed: float = 10.0
@export var acceleration: float = 5.0
@export var turning_radius: Curve


func _physics_process(delta: float) -> void:
	var current_speed := unit.velocity.length()
	var max_turning_angle := deg_to_rad(turning_radius.sample(speed / current_speed)) * 2
	var current_direction := unit.velocity.normalized()
	var desired_direction := calculate_direction(unit.global_position).normalized()
	var actual_direction := current_direction.lerp(desired_direction, max_turning_angle)
	
	unit.velocity = unit.velocity.lerp(actual_direction * speed, acceleration * delta)
	unit.move_and_slide()


func calculate_direction(position: Vector3) -> Vector3:
	if self.is_navigation_finished():
		return Vector3.ZERO
	var direction = position.direction_to(self.get_next_path_position())
	var motion = direction * speed
	return motion
