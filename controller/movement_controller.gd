extends Node
class_name MovementController

@export var selection_controller: SelectionController

func _on_ground_input_event(
	camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int
) -> void:
	if not (event is InputEventMouseButton and event.is_pressed()):
		return
	var mouse_event := event as InputEventMouseButton
	if not mouse_event.button_index == 2:
		return
	for unit in selection_controller.selected:
		unit.movement_component.target_position = event_position
