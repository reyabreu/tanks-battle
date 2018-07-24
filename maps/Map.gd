extends Node2D

func _ready():
	set_camera_limits()
	
func set_camera_limits():
	var map_limits = $Ground.get_used_rect()
	var map_cell_size = $Ground.cell_size 
	
	$Player/Camera.limit_left = map_limits.position.x * map_cell_size.x
	$Player/Camera.limit_top = map_limits.position.y * map_cell_size.y
	$Player/Camera.limit_right = map_limits.end.x * map_cell_size.x
	$Player/Camera.limit_bottom = map_limits.end.y * map_cell_size.y
	
func _on_Tank_shoot(bullet, _position, _direction):
	var new_bullet = bullet.instance()
	add_child(new_bullet)
	new_bullet.start(_position, _direction)	