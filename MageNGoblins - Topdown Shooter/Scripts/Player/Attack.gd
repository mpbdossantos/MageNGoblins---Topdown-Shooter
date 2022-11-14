extends Node
class_name AttackState

onready var weapons_dict: Dictionary ={
	"fire": class_weapon
}

var weapons_list: Array =[
	"fire"
]

var weapon_index:int = 0

var projectile_amount:int
export(int)var projectile_max_amount


export(String) var class_weapon

export(PackedScene) var fire_projectile

export(NodePath)onready var texture = get_node(texture) as Sprite
export(NodePath)onready var camera = get_node(camera) as Camera2D
export(NodePath)onready var character = get_node(character) as KinematicBody2D
export(NodePath)onready var projectile_spawner = get_node(projectile_spawner) as Position2D
 
func _ready()->void:
	projectile_amount = projectile_max_amount
	
func attack()->void:
	if not can_shoot(weapons_list[weapon_index]):
		return
		
	if Input.is_action_just_pressed("Attack") and not character.is_attacking:
		character.is_attacking = true
		update_ammo(weapons_list[weapon_index], "decrease", 1)
		texture.action_behavior(weapons_list[weapon_index])
		
func can_shoot(type:String)->bool:
	if type == "fire" and projectile_amount > 0:
		return true
				
	return false
	
func update_ammo(weapon_type: String, type: String, value:int) -> void:
	if weapon_type == "fire" and type == "increase":
		projectile_amount += value
		
	if weapon_type == "fire" and type == "decrease":
		projectile_amount -= value	
		
	verify_ammo_amount(weapon_type)

#limita a munição ao valor máximo	
func verify_ammo_amount(weapon_type: String)-> void:
	if weapon_type == "fire" and projectile_amount > projectile_max_amount:
		projectile_amount = projectile_max_amount		

func spawn_projectile(type: String)->void:
	var projectile_direction:Vector2 = (character.get_global_mouse_position() - character.global_position).normalized()
	var projectile = null
	match type:
		"fire":
			projectile = fire_projectile.instance()	
	get_tree().root.call_deferred("add_child", projectile)
	projectile.global_position = projectile_spawner.global_position
	#Conectar o Sinal de Câmera Shake
	projectile.direction = projectile_direction
	
