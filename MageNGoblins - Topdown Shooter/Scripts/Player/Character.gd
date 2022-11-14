extends KinematicBody2D
class_name Character

onready var move_state: Node = get_node("States/Move")
onready var attack_state: Node = get_node("States/Attack")

onready var texture: Sprite = get_node("Texture")

var is_attacking: bool = false

func _physics_process(_delta: float) -> void:
	move_state.move()
	attack_state.attack()
	texture.animate(move_state._velocity)

