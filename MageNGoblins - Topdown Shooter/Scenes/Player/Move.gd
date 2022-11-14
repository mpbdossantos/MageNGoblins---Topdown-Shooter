extends Node
class_name MoveState

var _velocity: Vector2

export(int) var walk_speed

export(NodePath) onready var character = get_node(character) as KinematicBody2D

func move()-> void:
	if character.is_attacking:
		return
	_velocity = get_direction() * move_state()
	character.move_and_slide(_velocity)
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	
func move_state()-> int:
	return walk_speed
