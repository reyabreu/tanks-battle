extends "res://tanks/Tank.gd"

onready var parent = get_parent()

export (float) var turret_speed
export (float) var detection_radius

var target = null

func _ready():
	# this is to allow individual tanks to have their own collision shape radius
	$DetectRadius/CollisionShape2D.shape = CircleShape2D.new()
	$DetectRadius/CollisionShape2D.shape.radius = detection_radius

func control(delta):
	if parent is PathFollow2D:
		parent.set_offset(parent.get_offset() + speed * delta)
		# clear position so it remains relative to parent all the time
		position = Vector2()
	else:
		# other movement code
		pass

func _process(delta):
	if target:
		var target_direction = (target.global_position - global_position).normalized()
		# we want the rotation in global coordinates, not relative to parent
		var current_direction = Vector2(1, 0).rotated($Turret.global_rotation)
		$Turret.global_rotation = current_direction.linear_interpolate(target_direction, turret_speed * delta).angle()
		if target_direction.dot(current_direction) > 0.9:
			print("enemy shoots bullet")
			shoot()

func _on_DetectRadius_body_entered(body):
		target = body

func _on_DetectRadius_body_exited(body):
	if body == target:
		target = null