extends Node2D
class_name SelectionController

const near_far_margin = .1 # frustum near/far planes distance from camera near/far planes

@export var movement_controller: MovementController
@export var camera_controller: CameraController

@onready var area_2d: Area2D = $SelectionArea
@onready var collision_shape_2d: CollisionShape2D = $SelectionArea/RectangleShape

var dragging := false
var drag_start := Vector2.ZERO
var selected: Array[Unit] = []
var select_rect := RectangleShape2D.new()

func _draw() -> void:
	if dragging:
		self.draw_rect(
			Rect2(drag_start, get_global_mouse_position() - drag_start),
			Color.WEB_GREEN,
			false,
			2.0
		)


func _on_mouse_controller_left_click_event(event: InputEventMouseButton) -> void:
	if event.is_pressed():
		drag_start = event.position
		dragging = true
	elif event.is_released():
		dragging = false
		_make_selection(event.position)
		self.queue_redraw()


func _on_mouse_controller_mouse_motion_event(_event: InputEventMouseMotion) -> void:
	if dragging:
		self.queue_redraw()


func _make_selection(drag_end: Vector2) -> void:
	select_rect.extents = abs(drag_end - drag_start) / 2
	collision_shape_2d.shape = select_rect
	collision_shape_2d.transform.origin = (drag_end + drag_start) / 2
	# Need to wait 2 frames because godot weirdness
	# More info at https://reddit.com/r/godot/comments/178d9hz/area2d_get_overlapping_bodies_is_not_detecting/
	await get_tree().process_frame
	await get_tree().process_frame
	selected.clear()
	print(area_2d.get_overlapping_bodies())
	for item in area_2d.get_overlapping_bodies():
		var screen_locator := item as UnitScreenLocator
		selected.append(screen_locator.unit)
