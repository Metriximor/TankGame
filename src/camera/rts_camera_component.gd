extends Node
class_name RTSCameraComponent

@export var camera: Camera3D
@export_category("Component Parameters")
@export var camera_speed := 25.0

var _current_pan_speed := 0.0


func _process(delta: float) -> void:
	var input_dir := Input.get_vector("pan_left", "pan_right", "pan_up", "pan_down")
	var camera_pan := input_dir * camera_speed * delta
	camera.global_position += Vector3(camera_pan.x, 0, camera_pan.y)
	
	var zoom := Input.get_axis("zoom_out", "zoom_in")
	print(Input.is_action_pressed("zoom_in"))
	camera.global_position.y += zoom * camera_speed 
