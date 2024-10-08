extends Node
class_name RTSCameraComponent

@export var camera: Camera3D
@export_category("Component Parameters")
@export var camera_speed := 25.0
@export var zoom_speed := 50.0

var _current_pan_speed := 0.0


func _process(delta: float) -> void:
	var input_dir := Input.get_vector("pan_left", "pan_right", "pan_up", "pan_down")
	var camera_pan := input_dir * camera_speed * delta
	camera.global_position += Vector3(camera_pan.x, 0, camera_pan.y)
	
	var zoomed_out := Input.is_action_just_pressed("zoom_out")
	var zoomed_in := Input.is_action_just_released("zoom_in")
	camera.global_position.y += _find_zoom_axis() * zoom_speed  * delta


func _find_zoom_axis() -> float:
	var zoom_in := 0.0
	var zoom_out := 0.0
	if Input.is_action_just_released("zoom_out"):
		zoom_out = 1.0
	if Input.is_action_just_released("zoom_in"):
		zoom_in = 1.0
	return zoom_in - zoom_out
