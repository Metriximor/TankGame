extends Node
class_name CameraController

@export var current_camera: Camera3D

func project_rect(rect: Rect2, z: float) -> PackedVector3Array:
	var p = PackedVector3Array() # our projected points
	p.resize(4)
	p[0] = current_camera.project_position(rect.position, z)
	p[1] = current_camera.project_position(rect.position + Vector2(rect.size.x, 0.0), z)
	p[2] = current_camera.project_position(rect.position + Vector2(rect.size.x, rect.size.y), z)
	p[3] = current_camera.project_position(rect.position + Vector2(0.0, rect.size.y), z)
	return p
