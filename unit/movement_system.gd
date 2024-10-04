extends NavigationAgent3D
class_name MovementSystem

@export var speed: float = 5.0

func update(position: Vector3) -> Vector3:
	if self.is_navigation_finished():
		return Vector3.ZERO
	var direction = position.direction_to(self.get_next_path_position())
	var motion = direction * speed
	return motion
