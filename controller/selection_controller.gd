extends Node2D
class_name SelectionController

const near_far_margin = .1 # frustum near/far planes distance from camera near/far planes

@export var movement_controller: MovementController
@export var camera_controller: CameraController

@onready var search_area: Node3D = $UnitSelectionArea

var dragging := false
var drag_start := Vector2.ZERO
var selected: Array[Dictionary] = []

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
		drag_start = Vector2.ZERO
		dragging = false
		_make_selection(event.position)
		
		self.queue_redraw()


func _on_mouse_controller_mouse_motion_event(event: InputEventMouseMotion) -> void:
	if dragging:
		self.queue_redraw()


func _make_selection(drag_end: Vector2) -> void:
	var space := search_area.get_world_3d().direct_space_state
	var query := PhysicsShapeQueryParameters3D.new()
	query.collision_mask = 2
	query.shape = make_frustum_collision_mesh(Rect2(drag_start, drag_end))
	selected = space.intersect_shape(query)
	print(selected)

func make_frustum_collision_mesh(rect: Rect2) -> ConvexPolygonShape3D:
	# create a convex polygon collision shape
	var shape = ConvexPolygonShape3D.new()
	# project 4 corners of the rect to the camera near plane
	var pnear = camera_controller.project_rect(
		rect, 
		camera_controller.current_camera.near + near_far_margin
	)
	# project 4 corners of the rect to the camera far plane
	var pfar = camera_controller.project_rect(
		rect,
		camera_controller.current_camera.far - near_far_margin
	)
	# create a frustum mesh from 8 projected points (6 faces in total, with 2 triangles per face and 3 vertices per triangle)
	
	shape.points = PackedVector3Array([
		# near face
		pnear[0], pnear[1], pnear[2], 
		pnear[1], pnear[2], pnear[3],
		# far face
		pfar[2], pfar[1], pfar[0],
		pfar[2], pfar[0], pfar[3],
		#top face
		pnear[0], pfar[0], pfar[1],
		pnear[0], pfar[1], pnear[1],
		#bottom face
		pfar[2], pfar[3], pnear[3],
		pfar[2], pnear[3], pnear[2],
		#left face
		pnear[0], pnear[3], pfar[3],
		pnear[0], pfar[3], pfar[0],
		#right face
		pnear[1], pfar[1], pfar[2],
		pnear[1], pfar[2], pnear[2]
	])
	return shape
