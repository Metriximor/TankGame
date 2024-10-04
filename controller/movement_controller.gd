extends Node
class_name MovementController

@export var delete_me: Unit

func _on_ground_input_event(
	camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int
) -> void:
	if not (event is InputEventMouseButton and event.is_pressed()):
		return
	var mouse_event := event as InputEventMouseButton
	if not mouse_event.button_index == 2:
		return
	delete_me.movement_system.target_position = event_position
	print("Clicked at %s" % event_position)
