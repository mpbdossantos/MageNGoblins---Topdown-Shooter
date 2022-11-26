extends Node2D
class_name GameLevel

const CELL_SIZE: int = 16

onready var mage: KinematicBody2D = get_node("LayeredObjects/Mage")
onready var base_terrain: TileMap = get_node("Terrain/BaseTerrain")
onready var navigation: Navigation2D = get_node("Terrain")

func _ready() -> void:
	define_camera_limit()
	
func define_camera_limit() -> void:
	var mage_camera: Camera2D = mage.get_node("Camera2D")
	var used_rect_tile: Rect2 = base_terrain.get_used_rect()
	
	mage_camera.limit_left = int(used_rect_tile.position.x)
	mage_camera.limit_top = int(used_rect_tile.position.y)
	
	mage_camera.limit_right = int(used_rect_tile.size.x * CELL_SIZE)
	mage_camera.limit_bottom = int(used_rect_tile.size.y * CELL_SIZE)

func _process(_delta: float) -> void:
	if mage == null:
		return

	send_player()
	
func send_player() -> void:
	get_tree().call_group("enemy", "get_player", mage, navigation)	
