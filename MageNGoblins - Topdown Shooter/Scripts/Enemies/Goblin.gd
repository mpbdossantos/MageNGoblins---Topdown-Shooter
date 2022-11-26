extends KinematicBody2D
class_name Goblin

onready var texture: Sprite = get_node("Texture")
onready var collision_shape: CollisionShape2D = get_node("Collision")
onready var monitoring_timer: Timer = get_node("MonitoringTimer")

var distance: float

var path: Array = []
var velocity: Vector2

export(float) var attack_cooldown

export(int) var damage
export(int) var move_speed
export(int) var distance_threshold

func get_player(player_reference, navigation: Navigation2D) -> void:
		path = navigation.get_simple_path(global_position, player_reference.global_position, false)
		if path.size() == 0:
			return
			
		distance = global_position.distance_to(player_reference.global_position)
		velocity = global_position.direction_to(path[1]) * move_speed
		
		if global_position == path[0]:
			path.pop_front()
			
func _physics_process(_delta: float) -> void:
	if distance < distance_threshold:
		return
		
	velocity = move_and_slide(velocity)
	verify_direction()
	animate()
	
func verify_direction() -> void:
	if velocity.x > 0:
		texture.flip_h = false
		
	if velocity.x < 0:
		texture.flip_h = true
	
func animate() -> void:
	pass

func set_collision() -> void:
	change_monitoring_state(true)
	monitoring_timer.start(attack_cooldown)	
	
func on_MonitoringTimer_timeout():
	change_monitoring_state(false)
	
func change_monitoring_state(state: bool) -> void:
	collision_shape.set_deferred("disabled", state)
	

func on_screen_entered():
	visible = true


func _on_screen_exited():
	visible = false
