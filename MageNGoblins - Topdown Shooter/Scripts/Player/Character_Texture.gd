extends Sprite
class_name CharacterTexture


var last_direction_state:bool

var spawn_position:float = 6
var on_action: bool = false

export(NodePath)onready var parent = get_node(parent) as KinematicBody2D
export(NodePath)onready var animation = get_node(animation) as AnimationPlayer
export(NodePath)onready var projectile_spawner = get_node(projectile_spawner) as Position2D

func animate(_velocity: Vector2)-> void:
	flip_h = set_orientation()
	if on_action:
		return
		
	move_behavior(_velocity)
	
#Esta função, faz com que saibamos em qual posição
#o mouse está, por exemplo, se estamos mais a direita
#ou a esquerda do nosso personagem para orientá-lo	
func set_orientation()->bool:
	var mouse_global_position:Vector2 = get_global_mouse_position()
	if mouse_global_position.x > parent.global_position.x:
		projectile_spawner.position.x = spawn_position
		last_direction_state = false
		return false

	if mouse_global_position.x < parent.global_position.x:
		projectile_spawner.position.x = -spawn_position
		last_direction_state = true
		return true
		
	return last_direction_state

func action_behavior(state: String)-> void:
	on_action = true
	animation.play(state)
	
func move_behavior(_velocity: Vector2)-> void:
	if _velocity != Vector2.ZERO:
		animation.play(get_move_state())
		return
		
	animation.play("Idle")
		

func get_move_state()-> String:
	return "Walk"


#Apenas para animações não loopaveis
#Para sabermos se podemos atacar ou não
func _on_animation_finished(anim_name: String)-> void:
	on_action = false
	if anim_name == "fire":
		parent.is_attacking = false
