extends CharacterBody3D
class_name Unit

@export var movement_system: MovementSystem

func _physics_process(delta: float) -> void:
	velocity = movement_system.update(global_position)
	move_and_slide()
