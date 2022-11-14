extends Area2D
class_name BaseProjectile

signal camera_shake

var already_destroyed: bool = false

var direction: Vector2 = Vector2.ZERO

export(int) var damage
export(int) var move_speed

export(float) var shake_lifetime
export(float) var shake_strength

export(PackedScene) var explosion_effect

func _physics_process(delta:float)-> void:
	translate(direction * move_speed * delta)


func _on_screen_exited():
	if not already_destroyed:
		kill()
		
func _on_body_entered(body)->void:
	if body is TileMap:
		kill()
	
	
func kill()-> void:
	emit_signal("camera_shake", shake_lifetime, shake_strength)
	already_destroyed = true
	#spawn_explosion()
	queue_free()


