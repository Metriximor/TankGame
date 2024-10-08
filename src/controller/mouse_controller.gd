extends Node
class_name MouseController

signal mouse_button_event(event: InputEventMouseButton)
signal mouse_motion_event(event: InputEventMouseMotion)
signal left_click_event(event: InputEventMouseButton)
signal right_click_event(event: InputEventMouseButton)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		_handle_input_event_mouse_button(event)
	elif event is InputEventMouseMotion:
		mouse_motion_event.emit(event)


func _handle_input_event_mouse_button(event: InputEventMouseButton) -> void:
	mouse_button_event.emit(event)
	if event.button_index == MOUSE_BUTTON_LEFT:
		left_click_event.emit(event)
	elif event.button_index == MOUSE_BUTTON_RIGHT:
		right_click_event.emit(event)
