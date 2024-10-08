extends StaticBody2D
class_name UnitScreenLocator

@export var unit: Unit

var _camera : Camera3D


func _physics_process(delta: float) -> void:
	if _camera == null:
		_camera = self.get_viewport().get_camera_3d()
	global_position = _update_screen_location(_camera)


func _update_screen_location(camera: Camera3D) -> Vector2:
	if camera.is_position_in_frustum(unit.global_position):
		return camera.unproject_position(unit.global_position)
	else:
		return Vector2.INF
