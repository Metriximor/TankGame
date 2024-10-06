extends CharacterBody3D
class_name Unit

@onready var movement_system: MovementSystem = $MovementSystem
@onready var unit_screen_locator: CollisionShape2D = $UnitScreenLocator/LocatorShape

func _physics_process(delta: float) -> void:
	velocity = movement_system.update(global_position)
	_update_screen_location()
	move_and_slide()


func _update_screen_location() -> void:
	var camera := get_viewport().get_camera_3d()
	if camera.is_position_in_frustum(global_position):
		unit_screen_locator.global_position = camera.unproject_position(global_position)
	else:
		unit_screen_locator.global_position = Vector2.INF
